       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCSDPCNYUIN.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 入院ＤＰＣ取得サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/02/09    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *              NACL-小豆沢  xx/xx/xx  グループ診療対応
      *              NACL-小豆沢  08/06/17  短期滞在手術基本料２の入院翌日の
      *                                     食事と入院料加算対応
      *              NACL-小豆沢  08/06/17  標欠と定数超過の外泊修正
      *              NACL-小豆沢  08/06/17  退院加算のレセ電対応（読み飛ばし）
      *                                     ・退院加算（療養病棟入院基本料等算定患者）
      *                                     ・退院加算（障害者施設等入院基本料等算定患者）
      *                                     ・早期退院加算
      *
      *              NACL-小豆沢  08/06/17  有床診療所の加算を注加算通番順に記録
      *                                     ・夜間緊急体制確保加算
      *                                     ・医師配置適合加算
      *                                     ・看護配置加算１
      *                                     ・看護配置加算２
      *                                     ・夜間看護配置加算１
      *                                     ・夜間看護配置加算２
      *
      *              NACL-小豆沢  08/06/17  小児入院医療管理料と回復期リハビリの
      *                                     加算を注加算通番順に記録
      *                                     ・プレイルーム、保育士等加算
      *                                     ・人工呼吸器使用加算（小児入院医療）
      *                                     ・重症患者回復病棟加算
      *
      *              NACL-小豆沢  08/06/17  特殊疾患病棟入院料の加算を注加算
      *                                     通番順に記録
      *                                     ・人工呼吸器使用加算（特殊疾患）
      *
      *              NACL-小豆沢  08/06/17  特定機能病院−精神病棟の加算を注加算
      *                                     通番順に記録
      *                                     ・重度認知症加算（特定機能病院精神病棟）
      *
      *              NACL-小豆沢  08/06/17  精神科急性期治療病棟入院料 及び
      *                                     精神科救急入院料の加算を注加算通番順に記録
      *                                     ・非定型抗精神病薬治療管理加算
      *
      *              NACL-小豆沢  08/06/17  療養病棟入院基本料 及び
      *                                     有床診療所療養病床入院基本料の加算を
      *                                     注加算通番順に記録
      *                                     ・褥瘡評価実施加算（療養病棟）
      *                                     ・褥瘡評価実施加算（有床診療所）
      *
      *              NACL-小豆沢  14/04/15  平成２６年度改定対応
      *              NACL-小豆沢  15/02/03  短期滞在手術等基本料で入院料が
      *                                     未算定日に入力された診療行為について
      *                                     ・医師コード
      *                                     ・病棟コード
      *                                     ・病棟区分
      *                                     が記録できなかった不具合を修正
      *              NACL-小豆沢  15/02/03  労災保険で入院した患者が医保で
      *                                     入力した診療行為について
      *                                     ・医師コード
      *                                     ・病棟コード
      *                                     ・病棟区分
      *                                     が記録できなかった不具合を修正
      *              NACL-小豆沢  15/06/10  選定入院時の外泊もレコード記録
      *                                     する対応
      *              NACL-小豆沢  15/06/10  選定入院時の外泊もレコード記録
      *                                     する対応
      *              NACL-小豆沢  16/03/10  平成２８年度改定対応
      *              NACL-小豆沢  16/08/01  医療区分、ＡＤＬ点数コメントの
      *                                     記録対応（平成２８年１０月診療分から）
      *平成２９年１０月改正対応
      *  05.00.00    NACL-小豆沢  17/08/31  居住費金額変更対応
      *                                     境界層対応
      *                                     生活療養負担コード分割対応
      *  05.00.01    NACL-小豆沢  17/12/07  同日再入院の食事記録修正
      *平成３０年４月改正対応
      *  05.00.00    NACL-小豆沢  18/02/27  入院時食事療養の金額変更対応
      *                                     食事負担額変更対応
      *                                     生活療養食事負担額変更対応
      *                                     居住費負担額変更対応
      *  05.00.00    NACL-小豆沢  18/04/3   夜間看護体制特定日減算対応
      *  05.00.00    NACL-小豆沢  18/04/11  他医受診対応
      *****************************************************************
      *
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
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-SRYACCT                 PIC 9(01).
           03  FLG-SRYACT                  PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-RJN                     PIC 9(01).
           03  FLG-ROUSAI                  PIC 9(01).
           03  FLG-RYAKU                   PIC 9(01).
           03  FLG-OK                      PIC 9(01).
           03  FLG-KSN                     PIC 9(01).
           03  FLG-SENTEI-SET              PIC 9(01).
           03  FLG-SENTEICDCHG             PIC 9(01).
           03  FLG-TSYRRK                  PIC 9(01).
           03  FLG-TNKRRK                  PIC 9(01).
           03  FLG-TENSUWRK                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX2                        PIC 9(04).
           03  IDX3                        PIC 9(04).
           03  IDX4                        PIC 9(04).
           03  IDX5                        PIC 9(04).
           03  IDX6                        PIC 9(04).
           03  IDX7                        PIC 9(04).
           03  KSN-IDX                     PIC 9(04).
           03  IDV                         PIC 9(04).
           03  TSY90-IDX                   PIC 9(02).
           03  IDX-TSY90                   PIC 9(04).
           03  IDX-NYUKSN                  PIC 9(02).
           03  IDX-CHUKSN1                 PIC 9(02).
           03  IDX-CHUKSN1S                PIC 9(02).
           03  IDX-CHUKSN1SS               PIC 9(02).
           03  IDX-CHUKSN2                 PIC 9(02).
           03  IDX-CHUKSN2S                PIC 9(02).
           03  IDX-CHUKSN2SS               PIC 9(02).
           03  IDX-COM                     PIC 9(02).
      *    同日再入院の食事編集時インデックス退避領域
           03  SET-IDX1                    PIC 9(04).
      *
      *    コンスタント値
       01  CONSTANT-AREA.
      *    標欠（１００分の１０減額）
           03  CONS-HYOKETU1               PIC X(09) VALUE "190107890".
      *    標欠（１００分の１５減額）
           03  CONS-HYOKETU2               PIC X(09) VALUE "190107990".
      *    標欠（１００分の３減額）（離島等）
           03  CONS-HYOKETU3               PIC X(09) VALUE "190108590".
      *    標欠（１００分の２減額）（離島等）
           03  CONS-HYOKETU4               PIC X(09) VALUE "190108690".
      *    定数超過入院基本料減額（１００分の１０）
           03  CONS-TEISU1                 PIC X(09) VALUE "190107690".
      *    定数超過入院基本料減額（１００分の２０）
           03  CONS-TEISU2                 PIC X(09) VALUE "190107790".
      *    定数超過入院基本料減額（１００分の１０）（特定入院料）
           03  CONS-TEISU3                 PIC X(09) VALUE "190122990".
      *    定数超過入院基本料減額（１００分の２０）（特定入院料）
           03  CONS-TEISU4                 PIC X(09) VALUE "190123090".
      *
      *    平成２８年度食事療養
      *    入院時食事療養（１）（流動食以外）
           03  CONS-SKJ-RYOYO-1-1          PIC X(09) VALUE "197000110".
      *    入院時食事療養（２）（流動食以外）
           03  CONS-SKJ-RYOYO-2-1          PIC X(09) VALUE "197000710".
      *    入院時食事療養（１）（流動食）
           03  CONS-SKJ-RYOYO-1-2          PIC X(09) VALUE "197003110".
      *    入院時食事療養（２）（流動食）
           03  CONS-SKJ-RYOYO-2-2          PIC X(09) VALUE "197003210".
      *    入院時生活療養（１）食事療養（流動食以外）
           03  CONS-SKJSEI-RYOYO-1-1       PIC X(09) VALUE "197001310".
      *    入院時生活療養（１）食事療養（流動食）
           03  CONS-SKJSEI-RYOYO-1-2       PIC X(09) VALUE "197003510".
      *    入院時生活療養（２）食事療養
           03  CONS-SKJSEI-RYOYO-2         PIC X(09) VALUE "197001710".
      *
      *    平成２８年度食事負担
      *    食事療養標準負担額（指定難病・小児慢性特定疾病患者）（一般）
           03  CONS-NANBYO-SKJFTN          PIC X(09) VALUE "197003310".
      *    食事療養標準負担額（精神１年超）（一般）
           03  CONS-SEISIN-SKJFTN          PIC X(09) VALUE "197003410".
      *
      *    その他診療行為で入力した入院料加算
           03  CONS-ETCNYUIN-TBL.
             05  CONS-ETCNYUIN-KSN         PIC X(09)  OCCURS 10.
      *    点数マスタ読み込みワーク用
           03  TTNS-CONST-MAX              PIC 9(03) VALUE 200.
      *
      *    一時領域
       01  WRK-AREA.
      *
      *    医療機関種別
           03  WRK-HOSPSBT                 PIC 9(01).
      *
           03  WRK-MM-X                    PIC X(02).
           03  WRK-MM-9     REDEFINES   WRK-MM-X
                                           PIC 9(02).
           03  WRK-GAIHAKU-SRYCD           PIC X(09).
           03  WRK-MEISAISU                PIC 9(03).
           03  WRK-KSNKBN                  PIC 9(03).
           03  WRK-CHUKSNCD-XXX            PIC X(04).
           03  WRK-NYUKHNKBN-XXX           PIC 9(03).
      *
      *    同日再入院処理用
           03  WRK-GETSUMATSU-YMD.
               05  WRK-GETSUMATSU-YY   PIC 9(04).
               05  WRK-GETSUMATSU-MM   PIC 9(02).
               05  WRK-GETSUMATSU-DD   PIC 9(02).
           03  WRK-DOUJITSU-KBN        PIC X(01).
      *
      *    入院会計ワーク
           03  WRK-NYUIN-TABLE.
               05  WRK-NYUIN-TBL           OCCURS  31.
                   07  WRK-HKNCOMBI-DAY    PIC 9(03).
                   07  WRK-SRYKBN          PIC X(02).
                   07  WRK-NYUINKHN        PIC X(09).
                   07  WRK-SHOKIKSN        PIC X(09).
                   07  WRK-HYOUKETSU       PIC X(09).
                   07  WRK-TEISU           PIC X(09).
                   07  WRK-GAIHAKU         PIC X(09).
                   07  WRK-GAIHAKU2        PIC X(09).
                   07  WRK-NYUKHNKSNKBN    PIC 9(03).
                   07  WRK-GAIHAKU-KBN     PIC 9(02).
                   07  WRK-CHUKSNCD        PIC X(04).
                   07  WRK-NYUKHNKBN       PIC 9(03).
      *
      *     医療観察用退避領域
           03  WRK-IRYOKNS-TABLE.
               05  WRK-IRYOKNS-TBL         OCCURS  31.
                   06  WRK-IRYOKNS-SRYCD-TBL.
                     07  WRK-IRYOKNS-SRYCD1        PIC X(09).
                     07  WRK-IRYOKNS-CHUKSNTUBAN1  PIC X(01).
                     07  WRK-IRYOKNS-SRYCD2        PIC X(09).
                     07  WRK-IRYOKNS-CHUKSNTUBAN2  PIC X(01).
                     07  WRK-IRYOKNS-SRYCD3        PIC X(09).
                     07  WRK-IRYOKNS-CHUKSNTUBAN3  PIC X(01).
                     07  WRK-IRYOKNS-SRYCD4        PIC X(09).
                     07  WRK-IRYOKNS-CHUKSNTUBAN4  PIC X(01).
      *              平成２８年度改定で新設された転院調整加算は
      *              診療行為画面より入力する為、SRYCD5に格納
                     07  WRK-IRYOKNS-SRYCD5        PIC X(09).
                     07  WRK-IRYOKNS-CHUKSNTUBAN5  PIC X(01).
                   06   WRK-IRYOKNS-SRYCD-TBLR   REDEFINES
                                             WRK-IRYOKNS-SRYCD-TBL.
                     07  WRK-IRYOKNS-SRYCD-OCC     OCCURS  5.
                       08  WRK-IRYOKNS-SRYCD       PIC X(09).
                       08  WRK-IRYOKNS-CHUKSNTUBAN PIC X(01).
                   06  WRK-IRYOKNS-SORT-FLG  PIC X(01).
           03   WRK-IRYOKNS-TAIHI                  PIC X(10).
      *
      *    入院会計並び替えワーク
           03  WRK-NYUIN-SORT-TABLE.
               05  WRK-NYUIN-SORT-TBL      OCCURS  31.
                   07  WRK-SO-MEISAISU     PIC 9(02).
                   07  WRK-SO-HKNCOMBI-DAY PIC 9(03).
                   07  WRK-SO-SRYKBN       PIC X(02).
                   07  WRK-SO-SRYCD        PIC X(09)  OCCURS 51.
                   07  WRK-SO-SRYCDTOTAL   PIC 9(14).
                   07  WRK-SO-TEN          PIC 9(07).
                   07  WRK-SO-KAISU        PIC 9(02).
                   07  WRK-SO-ADL-TEN-MOJI PIC X(04).
                   07  WRK-SO-GAIHAKU-TBL.
                     09  WRK-SO-GAIHAKU-KBN  PIC 9(02)  OCCURS 31.
                   07  WRK-SO-IRYOADL-DAY  PIC 9(02).
      *
      *
      *-------------------------------------------------------------
      *  平成２４年４月入院分からの注加算退避領域
      *
      *    入院料（Ａ１００番台）、特定入院料（Ａ３００番台）の注加算退避用
           03  WRK-CHUKSN-AREA-1.
             05   WRK-CHUKSN-TBL-1      OCCURS  50.
               07  WRK-CHUKSN-SRYCD-1          PIC X(09).
               07  WRK-CHUKSN-CHUCD-1.
                 09  WRK-CHUKSN-CHUKSNCD-1     PIC X(04).
                 09  WRK-CHUKSN-CHUKSNTUBAN-1  PIC X(01).
               07  WRK-CHUKSN-ZAITEN-1         PIC 9(08).
               07  WRK-CHUKSN-DAY-1            PIC 9(03)  OCCURS 31.
      *
      *    入院基本料等加算（Ａ２００番台）の注加算退避用
           03  WRK-CHUKSN-AREA-2.
             05   WRK-CHUKSN-TBL-2      OCCURS  50.
               07  WRK-CHUKSN-SRYCD-2          PIC X(09).
               07  WRK-CHUKSN-CHUCD-2.
                 09  WRK-CHUKSN-CHUKSNCD-2     PIC X(04).
                 09  WRK-CHUKSN-CHUKSNTUBAN-2  PIC X(01).
               07  WRK-CHUKSN-ZAITEN-2         PIC 9(08).
               07  WRK-CHUKSN-DAY-2            PIC 9(03)  OCCURS 31.
      *
      *    注加算以外の加算退避用
           03  WRK-NYUKSN-AREA-1.
             05   WRK-NYUKSN-TBL-1             OCCURS  50.
               07  WRK-NYUKSN-SRYCD-1          PIC X(09).
               07  WRK-NYUKSN-ZAITEN-1         PIC 9(08).
               07  WRK-NYUKSN-DAY-1            PIC 9(03)  OCCURS 31.
      *
      *    並び替え時の退避用
           03  WRK-CHUKSN-TAIHI.
             05  WRK-CHUKSN-SRYCD-T          PIC X(09).
             05  WRK-CHUKSN-CHUCD-T.
               07  WRK-CHUKSN-CHUKSNCD-T     PIC X(04).
               07  WRK-CHUKSN-CHUKSNTUBAN-T  PIC X(01).
             05  WRK-CHUKSN-ZAITEN-T         PIC 9(08).
             05  WRK-CHUKSN-DAY-T            PIC 9(03)  OCCURS 31.
      *-------------------------------------------------------------
      *
      *    診療コード計集計用
           03  WRK-SRYCD-X                 PIC X(09).
           03  WRK-SRYCD-9    REDEFINES    WRK-SRYCD-X
                                           PIC 9(09).
      *
      *    システム管理食事退避領域
           03  WRK-SYS5000-SKJ             OCCURS  5.
               05  WRK-SYS5000-SHOKUCD     PIC X(09) OCCURS 31.
      *    食事ワーク
           03  WRK-SKJ-HKNCOMBI-ASA        PIC 9(03) OCCURS 31.
           03  WRK-SKJ-HKNCOMBI-HIRU       PIC 9(03) OCCURS 31.
           03  WRK-SKJ-HKNCOMBI-YORU       PIC 9(03) OCCURS 31.
      *    食堂加算判定用食事ワーク
           03  WRK-SKJ-ASA-ARI             PIC 9(03) OCCURS 31.
           03  WRK-SKJ-HIRU-ARI            PIC 9(03) OCCURS 31.
      *
      *    他保険での食堂加算判定用領域
           03  WRK-TAHOKEN-SHOKUDOU-TABLE.
               05  WRK-TAHOKEN-SHOKUDOU-FLG    PIC  X(01)  OCCURS 31.
      *
      *    食事ワーク４（食事療養費）（平成１８年４月以降）
           03  WRK-SKJ4-TABLE.
               05  WRK-SKJ4-TBL          OCCURS  93.
                   07  WRK-SKJ4-HKNCOMBI-DAY   PIC 9(03).
                   07  WRK-SKJ4-RYOYO          PIC X(09).
                   07  WRK-SKJ4-KAISU          PIC 9(02).
      *    食事ワーク５（特別食加算）（平成１８年４月以降）
           03  WRK-SKJ5-TABLE.
               05  WRK-SKJ5-TBL          OCCURS  93.
                   07  WRK-SKJ5-HKNCOMBI-DAY   PIC 9(03).
                   07  WRK-SKJ5-TOKU-SHOKU     PIC X(09).
                   07  WRK-SKJ5-KAISU          PIC 9(02).
      *    食事ワーク６（食堂加算）（平成１８年４月以降）
           03  WRK-SKJ6-TABLE.
               05  WRK-SKJ6-TBL          OCCURS  31.
                   07  WRK-SKJ6-HKNCOMBI-DAY   PIC 9(03).
                   07  WRK-SKJ6-SHOKUDOU       PIC X(09).
                   07  WRK-SKJ6-KAISU          PIC 9(02).
      *    食事ワーク７
           03  WRK-SKJ7-TABLE.
               05  WRK-SKJ7-TBL           OCCURS  62.
                   07  WRK-SKJ7-HKNCOMBI-DAY   PIC 9(03).
                   07  WRK-SKJ7-GRP.
                       09  WRK-SKJ7-RYOYO       PIC X(09).
                       09  WRK-SKJ7-RYOYO-SU    PIC 9(01).
                       09  WRK-SKJ7-RYOYO-RYU       PIC X(09).
                       09  WRK-SKJ7-RYOYO-RYU-SU    PIC 9(01).
                       09  WRK-SKJ7-SHOKUDOU    PIC X(09).
                       09  WRK-SKJ7-TOKU-SHOKU  PIC X(09).
                       09  WRK-SKJ7-TOKU-SHOKU-SU PIC 9(01).
                       09  WRK-SKJ7-TOKU-SHOKU-KAISU1 PIC 9(02).
                       09  WRK-SKJ7-TOKU-SHOKU-KAISU2 PIC 9(02).
                       09  WRK-SKJ7-TOKU-SHOKU-KAISU3 PIC 9(02).
                       09  WRK-SKJ7-SKJFTN      PIC X(09).
                       09  WRK-SKJ7-SKJFTN-SU   PIC 9(01).
                   07  WRK-SKJ7-SRYCDTOTAL      PIC 9(14).
                   07  WRK-SKJ7-KAISU           PIC 9(02).
                   07  WRK-SKJ7-SAINYUINKBN     PIC 9(01).
      *
      *    入院時生活療養（環境療養）ワーク
           03  WRK-KANKYO-TABLE.
               05  WRK-KANKYO-TBL           OCCURS  31.
                   07  WRK-KANKYO-HKNCOMBI-DAY  PIC 9(03).
                   07  WRK-KANKYO-GRP.
                       09  WRK-KANKYO-RYOYO     PIC X(09).
                       09  WRK-KANKYO-FTN       PIC X(09).
                   07  WRK-KANKYO-SRYCDTOTAL    PIC 9(14).
                   07  WRK-KANKYO-KAISU         PIC 9(02).
      *
      *    点数マスタ退避ワーク
           03  WRK-TENSU-OCC                   OCCURS  200.
               05  WRK-TENSU-SRYCD             PIC X(09).
               05  WRK-TENSU-DATA              PIC X(2000).
           03  WRK-TENSU-CD                    PIC X(09).
           03  TTNS-IDX                        PIC 9(03).
           03  TTNS-MAX                        PIC 9(03).
      *
      *    食事負担ワーク（平成１８年４月以降）
           03  WRK-SKJFTN2-TABLE.
               05  WRK-SKJFTN2-TBL       OCCURS  93.
                   07  WRK-SKJFTN2-HKNCOMBI-DAY PIC 9(03).
                   07  WRK-SKJFTN2-SRYCD        PIC X(09).
                   07  WRK-SKJFTN2-KAISU        PIC 9(02).
      *
      *    同日再入院日の再入院分食事算定について、入退院日を変更する為
      *    の区分
           03  WRK-SAINYUINKBN-ASA             PIC X(01)   OCCURS  31.
           03  WRK-SAINYUINKBN-HIRU            PIC X(01)   OCCURS  31.
           03  WRK-SAINYUINKBN-YORU            PIC X(01)   OCCURS  31.
      *
      *    入院料算定の判定用領域
           03  WRK-NACCT-DAY-TBL.
               05  WRK-NACCT-DAY               PIC  9(03)  OCCURS 31.
      *
      *    選定療養退避用テーブル
           03  TABLE-SENTEI.
               05  TBL-SENTEI                  PIC 9(01)   OCCURS  31.
      *
      *    病棟区分退避用テーブル
           03  TABLE-BTUKBN.
               05  TBL-RRKNUM                  PIC 9(03)   OCCURS  31.
               05  TBL-BTUNUM                  PIC 9(02)   OCCURS  31.
               05  TBL-BTUKBN                  PIC X(02)   OCCURS  31.
               05  TBL-SRYKA                   PIC X(02)   OCCURS  31.
               05  TBL-DRCD                    PIC X(05)   OCCURS  31.
      *    病棟区分退避用テーブル（同日再入院分）
           03  TABLE-BTUKBN2.
               05  TBL-BTUNUM2                 PIC 9(02)   OCCURS  31.
               05  TBL-BTUKBN2                 PIC X(02)   OCCURS  31.
               05  TBL-SRYKA2                  PIC X(02)   OCCURS  31.
               05  TBL-DRCD2                   PIC X(05)   OCCURS  31.
           03  WRK-SET-DD                      PIC 9(02).
      *
           03  WRK-DAY-X                       PIC X(02).
           03  WRK-DAY-9        REDEFINES      WRK-DAY-X
                                               PIC 9(02).
      *    選定入院時の外泊判定用
           03  WRK-SENTEI-GAIGAKU              PIC 9(01)   OCCURS  31.
      *
      *    夜間看護体制特定日減算領域
           03  WRK-KANGOGEN                    PIC X(09)   OCCURS  31.
      *
      *    患者所得情報の退避領域
       01  WRK-SYOTOKU-SKJKBN-AREA.
           03  WRK-SYOTOKU-SKJKBN       PIC X(01)   OCCURS  93.
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1001.INC".
           COPY    "CPSK5000.INC".
           COPY    "CPSK5001.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為マスター
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    選定療養費
       01  SENTEICDCHG-REC.
           COPY    "CPSENTEICDCHG.INC".
      *
      *    低所得
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *    年金
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    入院時生活療養費負担額取得サブ
           COPY    "CPORCSNYULIFE.INC".
      *
      *    入院時生活療養費負担額取得サブ（平成２８年４月改定対応）
           COPY    "CPORCSNYULIFE2.INC".
      *
      *    患者所得情報編集サブ
           COPY    "CPORCSSYOTOKU.INC".
      *
      *    入院料未算定日取得サブ
           COPY    "CPORCSNYUINDAY.INC".
      *
      *    食事負担据え置き対象取得パラメタ
           COPY    "CPORCSSKJKEEP.INC".
      *
      *    食事保険取得サブ
           COPY    "CPORCSSKJHKN.INC".
      *
      *    療養レセコメント取得サブ
           COPY    "CPORCSRYOCOM.INC".
      *
      *    夜間看護体制特定日減算取得サブ
           COPY    "CPORCSKANGOGEN.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    入院ＤＰＣ取得パラメタ
           COPY    "CPORCSDPCNYUIN.INC".
      *
       PROCEDURE                   DIVISION    USING
           ORCSDPCNYUIN-AREA
            SPA-AREA
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
           INITIALIZE                  LNK-DPCNYUIN-HENKYAKU-AREA
           INITIALIZE                  CONS-ETCNYUIN-TBL
           MOVE    ZERO                TO  LNK-DPCNYUIN-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-DPCNYUIN-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-DPCNYUIN-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
      *     DISPLAY "------------HENKYAKU--------------------------"
      *     DISPLAY "LNK-DPCNYUIN-PTID = " LNK-DPCNYUIN-PTID
      *     PERFORM   VARYING  IDX FROM 1 BY 1
      *               UNTIL IDX > 40
      *     DISPLAY "IDX = " IDX
      *     DISPLAY "LNK-DPCNYUIN-PTID = " LNK-DPCNYUIN-PTID
      *     DISPLAY "LNK-DPCNYUIN-SRYKA   = " LNK-DPCNYUIN-SRYKA(3 IDX)
      *     DISPLAY "LNK-DPCNYUIN-SRYKA2  = " LNK-DPCNYUIN-SRYKA2(3 IDX)
      *     DISPLAY "LNK-DPCNYUIN-RECSKB = " LNK-DPCNYUIN-RECSKB(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYSKB = " LNK-DPCNYUIN-SRYSKB(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYSKB2= " LNK-DPCNYUIN-SRYSKB(3 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SRYCD = " LNK-DPCNYUIN-SRYCD(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYCD2= " LNK-DPCNYUIN-SRYCD(3 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SURYO = " LNK-DPCNYUIN-SURYO(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-TEN   = " LNK-DPCNYUIN-TEN(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(1) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(3 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(2) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(3 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(3) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(3 IDX 3)
      *     DISPLAY "    --- SEIKATSU -----"
      *     DISPLAY "LNK-DPCNYUIN-PTID = " LNK-DPCNYUIN-PTID
      *     DISPLAY "LNK-DPCNYUIN-SRYKA   = " LNK-DPCNYUIN-SRYKA(4 IDX)
      *     DISPLAY "LNK-DPCNYUIN-SRYKA2  = " LNK-DPCNYUIN-SRYKA2(4 IDX)
      *     DISPLAY "LNK-DPCNYUIN-RECSKB = " LNK-DPCNYUIN-RECSKB(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYSKB = " LNK-DPCNYUIN-SRYSKB(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYSKB2= " LNK-DPCNYUIN-SRYSKB(4 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SRYCD = " LNK-DPCNYUIN-SRYCD(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SRYCD2= " LNK-DPCNYUIN-SRYCD(4 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SURYO = " LNK-DPCNYUIN-SURYO(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-TEN   = " LNK-DPCNYUIN-TEN(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(1) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(4 IDX 1)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(2) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(4 IDX 2)
      *     DISPLAY "LNK-DPCNYUIN-SAINYUINKBN(3) = "
      *              LNK-DPCNYUIN-SAINYUINKBN(4 IDX 3)
      *     END-PERFORM
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    算定年月チェック
           IF    ( LNK-DPCNYUIN-SANTEIYM    =   SPACE )
               MOVE    1                 TO  LNK-DPCNYUIN-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                        PTINF-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  PTINF-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF             NOT =   ZERO
               MOVE    2                 TO  LNK-DPCNYUIN-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    保険区分チェック
      **     IF     LNK-DPCNYUIN-HKNKBN  =   "1"  OR  "2"
      **         CONTINUE
      **     ELSE
      **         MOVE    3               TO  LNK-DPCNYUIN-RC
      **         GO  TO  100-PRM-CHK-EXT
      **     END-IF
      *
      *    入院中のチェック（入院会計マスター検索）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  NACCT-SRYYM
           MOVE    "5"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           NOT =   ZERO
               MOVE    4                   TO  LNK-DPCNYUIN-RC
           ELSE
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT          NOT =   ZERO
                    MOVE    4              TO  LNK-DPCNYUIN-RC
               ELSE
                    PERFORM    VARYING   IDX1   FROM   1   BY   1
                               UNTIL     IDX1   >      31
                        MOVE   NACCT-DAY (IDX1)
                                           TO  WRK-HKNCOMBI-DAY(IDX1)
                    END-PERFORM
               END-IF
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key17"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    医療機関種別の取得（システム管理テーブルより）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1001"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-DPCNYUIN-SANTEIYM
                                       TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    LNK-DPCNYUIN-HOSPNUM TO SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               IF    FLG-SYSKANRI   =    ZERO
                   MOVE   SYS-1001-HOSPSBT  TO  WRK-HOSPSBT
               ELSE
                   MOVE   ZERO              TO  WRK-HOSPSBT
               END-IF
           END-IF
      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *短期滞在手術基本料２と３の入院料未算定日について取得
           INITIALIZE                             ORCSNYUINDAY-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM       TO  LNK-NYUINDAY-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID          TO  LNK-NYUINDAY-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM      TO  LNK-NYUINDAY-SANTEIYM
           CALL    "ORCSNYUINDAY"         USING   ORCSNYUINDAY-AREA
                                                  SPA-AREA
      *
      *食事の保険組合せ取得
           INITIALIZE                             ORCSSKJHKN-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM       TO  LNK-SKJHKN-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID          TO  LNK-SKJHKN-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM      TO  LNK-SKJHKN-SANTEIYM
           CALL    "ORCSSKJHKN"         USING     ORCSSKJHKN-AREA
                                                  ORCSNYUINDAY-AREA
                                                  SPA-AREA
      *
      *夜間看護体制特定日減算取得
           IF      LNK-DPCNYUIN-SANTEIYM       >=  "201804"
             INITIALIZE                            ORCSKANGOGEN-AREA
             MOVE    LNK-DPCNYUIN-HOSPNUM      TO  LNK-KANGOGEN-HOSPNUM
             MOVE    LNK-DPCNYUIN-PTID         TO  LNK-KANGOGEN-PTID
             MOVE    LNK-DPCNYUIN-SANTEIYM     TO  LNK-KANGOGEN-SANTEIYM
             CALL    "ORCSKANGOGEN"     USING      ORCSKANGOGEN-AREA
                                                   SPA-AREA
             IF      LNK-KANGOGEN-RC           =   ZERO
               PERFORM    VARYING   IDX1  FROM   1   BY   1
                           UNTIL    IDX1   >    31
                 MOVE  LNK-KANGOGEN-SRYCD(IDX1) TO  WRK-KANGOGEN(IDX1)
               END-PERFORM
             END-IF
           END-IF
      *
      *医療区分、ＡＤＬ点数コメントの取得（平成２８年１０月診療分以降）
           IF     LNK-DPCNYUIN-SANTEIYM       >=  "201610"
              INITIALIZE                          ORCSRYOCOM-AREA
              MOVE    LNK-DPCNYUIN-HOSPNUM    TO  LNK-RYOCOM-HOSPNUM
              MOVE    LNK-DPCNYUIN-PTID       TO  LNK-RYOCOM-PTID
              MOVE    LNK-DPCNYUIN-SANTEIYM   TO  LNK-RYOCOM-SANTEIYM
              CALL    "ORCSRYOCOM"        USING   ORCSRYOCOM-AREA
                                                  SPA-AREA
           END-IF
      *
      *レセ電対象保険組合せ番号の取得
           PERFORM    VARYING   IDX   FROM   1   BY   1
                      UNTIL      IDX  >    31
               IF     WRK-HKNCOMBI-DAY(IDX)   NOT =   ZERO
                   INITIALIZE                          HKNCOMBI-REC
                   MOVE    LNK-DPCNYUIN-HOSPNUM  TO  COMB-HOSPNUM
                   MOVE    LNK-DPCNYUIN-PTID     TO  COMB-PTID
                   MOVE    WRK-HKNCOMBI-DAY(IDX)   TO  COMB-HKNCOMBINUM
                   MOVE    "tbl_hkncombi"          TO  MCP-TABLE
                   MOVE    "key"                   TO  MCP-PATHNAME
                   PERFORM 910-HKNCOMBI-SELECT-SEC
                   IF      FLG-HKNCOMBI            =   ZERO
                       MOVE    "tbl_hkncombi"      TO  MCP-TABLE
                       MOVE    "key"               TO  MCP-PATHNAME
                       PERFORM   910-HKNCOMBI-READ-SEC
                       IF   FLG-HKNCOMBI         =  ZERO
                            IF    ( COMB-HKNNUM   = "971" OR "973" OR
                                                    "975")
                                            OR
                                  ( COMB-HKNNUM(1:2)  =    "98")
                                MOVE   ZERO   TO  WRK-HKNCOMBI-DAY(IDX)
                            ELSE
      *
                                CONTINUE
      *
                            END-IF
                       ELSE
                           MOVE    5          TO  LNK-DPCNYUIN-RC
                       END-IF
      *                保険組合せクローズ
                       MOVE    "tbl_hkncombi"          TO  MCP-TABLE
                       MOVE    "key"                   TO  MCP-PATHNAME
                       PERFORM   900-CLOSE-SEC
                   ELSE
      *                保険組合せクローズ
                       MOVE    "tbl_hkncombi"          TO  MCP-TABLE
                       MOVE    "key"                   TO  MCP-PATHNAME
                       PERFORM   900-CLOSE-SEC
                       MOVE    5              TO  LNK-DPCNYUIN-RC
                   END-IF
               END-IF
           END-PERFORM
      *
      *----------TEST----------------------
      ***      MOVE    2    TO  LNK-DPCNYUIN-SET-HKNCOMBI(2)
      *
      *食事算定用の保険組合せ判定領域にセット
           PERFORM    VARYING   IDX   FROM   1   BY   1
                      UNTIL      IDX  >    31
               IF     WRK-HKNCOMBI-DAY(IDX)   NOT =   ZERO
                   IF (WRK-HKNCOMBI-DAY(IDX) =
                                 LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(10))
                       MOVE   WRK-HKNCOMBI-DAY(IDX)
                                   TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                                        WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                        WRK-SKJ-HKNCOMBI-YORU(IDX)
                   END-IF
               END-IF
           END-PERFORM
      *
      *
      *同日再入院日の保険組合せ編集
           PERFORM    VARYING   IDX   FROM   1   BY   1
                      UNTIL      IDX  >    31
               IF     LNK-NYUINDAY-DOUJITSU-KBN(IDX)   =   "1"
      *            退院分
                   IF (LNK-NYUINDAY-DOUJITSU-T-HKNCOMBI(IDX) =
                                 LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(10))
                       IF     LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX) = "0"
                           MOVE   ZERO  TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                       IF     LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX) = "1"
                           MOVE   LNK-NYUINDAY-DOUJITSU-T-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                           MOVE   ZERO  TO   WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                       IF     LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX) = "2"
                           MOVE   LNK-NYUINDAY-DOUJITSU-T-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX)
                           MOVE   ZERO  TO   WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                       IF     LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX) = "3"
                           MOVE   LNK-NYUINDAY-DOUJITSU-T-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                   END-IF
      *            再入院分
                   IF (LNK-NYUINDAY-DOUJITSU-HKNCOMBI(IDX) =
                                 LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(10))
                       IF     LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX) = "1"
                           MOVE   LNK-NYUINDAY-DOUJITSU-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-ASA(IDX)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                       IF     LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX) = "2"
                           MOVE   LNK-NYUINDAY-DOUJITSU-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-HIRU(IDX)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                       IF     LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX) = "3"
                           MOVE   LNK-NYUINDAY-DOUJITSU-HKNCOMBI(IDX)
                                        TO   WRK-SKJ-HKNCOMBI-YORU(IDX)
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *月末に同日再入院時のレセ電対象保険組合せ番号の取得
      *    月末日を取得
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    LNK-DPCNYUIN-SANTEIYM
                                       TO  LNK-DAY7-YM
           CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                           LNK-DAY7-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY7-KOYOMI     TO  WRK-GETSUMATSU-YMD
           END-IF
      *
           MOVE    SPACE                   TO  WRK-DOUJITSU-KBN
           IF (LNK-NYUINDAY-DOUJITSU-KBN(WRK-GETSUMATSU-DD) = "1") AND
              (LNK-NYUINDAY-DOUJITSU-HKNHENKBN(WRK-GETSUMATSU-DD) = "3")
              IF   LNK-DPCNYUIN-HKNKBN  = LNK-NYUINDAY-DOUJITSU-HKNSYU
                                            (WRK-GETSUMATSU-DD)
                MOVE      "1"              TO  WRK-DOUJITSU-KBN
              END-IF
           END-IF
      *
      *食事保険指定で記録対象となる入力があるか確認
           PERFORM    VARYING  IDX1   FROM  1  BY  1
             UNTIL    IDX1     >   31
                IF LNK-DPCNYUIN-HKNKBN  =  LNK-SKJHKN-HKNSYU(IDX1 1)
                    MOVE      "1"              TO  WRK-DOUJITSU-KBN
                END-IF
                IF LNK-DPCNYUIN-HKNKBN  =  LNK-SKJHKN-HKNSYU(IDX1 2)
                    MOVE      "1"              TO  WRK-DOUJITSU-KBN
                END-IF
           END-PERFORM
      *
      *食事保険指定で記録対象となる入力があれば保険組合せ番号をセット
           PERFORM    VARYING  IDX1   FROM  1  BY  1
             UNTIL    IDX1     >   31
      **          DISPLAY "IDX1 = " IDX1 
      **                  " T-SKJKBN = " 
      **                  LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)
      **                  " SAI-SKJKBN = " 
      **                  LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)
      *         入院分（退院分）
                IF  LNK-SKJHKN-HKNCOMBINUM(IDX1 1) NOT = SPACE
                    IF   LNK-SKJHKN-HKNCOMBINUM(IDX1 1)  =
                                 LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(10)
      *
      *                 同日再入院日以外
                        IF   LNK-NYUINDAY-DOUJITSU-KBN(IDX1)  = SPACE
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 1)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 朝食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "1"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 1)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                        END-IF
      *                 昼食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "2"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 1)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                        END-IF
      *                 夕食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "3"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 1)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
                    ELSE
      *                 クリア処理
      *                 同日再入院日以外
                        IF   LNK-NYUINDAY-DOUJITSU-KBN(IDX1)  = SPACE
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 朝食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "1"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                        END-IF
      *                 昼食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "2"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                        END-IF
      *                 夕食まで
                        IF   LNK-NYUINDAY-DOUJITSU-T-SKJKBN(IDX1)  = "3"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
                    END-IF
                END-IF
      *         同日再入院分
                IF  LNK-SKJHKN-HKNCOMBINUM(IDX1 2) NOT = SPACE
                    IF   LNK-SKJHKN-HKNCOMBINUM(IDX1 2)  =
                                 LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                 LNK-DPCNYUIN-SET-HKNCOMBI(10)
      *
      *                 朝食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "1"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 2)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 昼食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "2"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 2)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 夕食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "3"
                            MOVE  LNK-SKJHKN-HKNCOMBINUM(IDX1 2)(2:3)
                                         TO  WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
                    ELSE
      *                 クリア処理
      *                 朝食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "1"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                             WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 昼食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "2"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                             WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
      *                 夕食から
                        IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)  = "3"
                            MOVE  ZERO
                                         TO  WRK-SKJ-HKNCOMBI-YORU(IDX1)
                        END-IF
                    END-IF
                END-IF
           END-PERFORM
      **     PERFORM    VARYING  IDX1   FROM  1  BY  1
      **       UNTIL    IDX1     >   31
      **         DISPLAY "IDX1 = " IDX1
      **         DISPLAY "WRK-SKJ-HKNCOMBI-ASA(IDX1)  = "
      **                  WRK-SKJ-HKNCOMBI-ASA(IDX1)
      **         DISPLAY "WRK-SKJ-HKNCOMBI-HIRU(IDX1) = "
      **                  WRK-SKJ-HKNCOMBI-HIRU(IDX1)
      **         DISPLAY "WRK-SKJ-HKNCOMBI-YORU(IDX1) = "
      **                  WRK-SKJ-HKNCOMBI-YORU(IDX1)
      **     END-PERFORM
      *
      *入院料の取得
           MOVE    ZERO                    TO  FLG-OK
           MOVE    SPACE                   TO  WRK-NACCT-DAY-TBL
           INITIALIZE                          WRK-NACCT-DAY-TBL
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "1"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                   MOVE      ZERO     TO      FLG-RYAKU
                                              WRK-KSNKBN
                   MOVE      SPACE    TO      WRK-CHUKSNCD-XXX
                   MOVE      ZERO     TO      WRK-NYUKHNKBN-XXX
                   IF    NACCT-SRYCDTOTAL     =    99999916
                       CONTINUE
                   ELSE
      *                該当入院行為テーブルの読み込み
                       PERFORM    210-NYUINACT-GET-SEC
      *                入院基本料と初期加算（長期減算）の退避
                       PERFORM    VARYING   IDX1   FROM   1   BY   1
                                  UNTIL     IDX1   >   31
                           IF     NACCT-DAY(IDX1)  NOT =  ZERO
                             MOVE   NACCT-DAY(IDX1)  TO   WRK-NACCT-DAY
                                                                (IDX1)
                           END-IF
                           IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)
                           AND   (NACCT-DAY(IDX1)    NOT =  ZERO) 
                               MOVE    NSRY-SRYCD(1)   TO  
                                                   WRK-NYUINKHN(IDX1)
      *
      *                      医療観察
                             IF  NSRY-SRYCD(2)(1:3) =  "188"
                                  MOVE  NSRY-SRYCD(2)   TO
                                              WRK-IRYOKNS-SRYCD1(IDX1)
                             END-IF
                             IF  NSRY-SRYCD(3)(1:3) =  "188"
                                MOVE  NSRY-SRYCD(3)   TO
                                              WRK-IRYOKNS-SRYCD2(IDX1)
                             END-IF
                             IF  NSRY-SRYCD(4)(1:3) =  "188"
                                MOVE  NSRY-SRYCD(4)   TO
                                              WRK-IRYOKNS-SRYCD3(IDX1)
                             END-IF
                             IF  NSRY-SRYCD(5)(1:3) =  "188"
                                MOVE  NSRY-SRYCD(5)   TO
                                              WRK-IRYOKNS-SRYCD4(IDX1)
                             END-IF
      *
      *                      入院の期間加算
                             IF  (NSRY-SRYCD(2) NOT =  SPACE)  AND
                                 (NSRY-SRYCD(2) NOT = CONS-HYOKETU1 AND
                                                      CONS-HYOKETU2 AND
                                                      CONS-HYOKETU3 AND
                                                      CONS-HYOKETU4 AND
                                                      CONS-TEISU1   AND
                                                      CONS-TEISU2   AND
                                                      CONS-TEISU3   AND
                                                      CONS-TEISU4)
                                                                AND
                                   (NSRY-SRYCD(2)(1:3) NOT = "188")
                                 MOVE   NSRY-SRYCD(2)  TO
                                                   WRK-SHOKIKSN(IDX1)
                             END-IF
      *                      標欠コード
                             IF  (NSRY-SRYCD(2)  NOT =   SPACE)  AND
                                 (NSRY-SRYCD(2)  =   CONS-HYOKETU1 OR
                                                     CONS-HYOKETU2 OR
                                                     CONS-HYOKETU3 OR
                                                     CONS-HYOKETU4)
                                 MOVE   NSRY-SRYCD(2)  TO
                                                 WRK-HYOUKETSU(IDX1)
                             END-IF
      *                      標欠コード
                             IF  (NSRY-SRYCD(3)  NOT =   SPACE)  AND
                                 (NSRY-SRYCD(3)  =   CONS-HYOKETU1 OR
                                                     CONS-HYOKETU2 OR
                                                     CONS-HYOKETU3 OR
                                                     CONS-HYOKETU4)
                                 MOVE   NSRY-SRYCD(3)  TO
                                                   WRK-HYOUKETSU(IDX1)
                             END-IF
      *                      定数超過コード
                             IF  (NSRY-SRYCD(2)  NOT =   SPACE)  AND
                                 (NSRY-SRYCD(2)  =   CONS-TEISU1 OR
                                                     CONS-TEISU2 OR
                                                     CONS-TEISU3 OR
                                                     CONS-TEISU4)
                                 MOVE   NSRY-SRYCD(2)  TO
                                                 WRK-TEISU(IDX1)
                             END-IF
      *                      定数超過コード
                             IF  (NSRY-SRYCD(3)  NOT =   SPACE)  AND
                                 (NSRY-SRYCD(3)  =   CONS-TEISU1 OR
                                                     CONS-TEISU2 OR
                                                     CONS-TEISU3 OR
                                                     CONS-TEISU4)
                                 MOVE   NSRY-SRYCD(3)  TO
                                                 WRK-TEISU(IDX1)
                             END-IF
      *                      診療区分
                             MOVE    NACCT-SRYKBN
                                              TO  WRK-SRYKBN(IDX1)
                             IF   FLG-RYAKU   =   ZERO
      *
      *                           外泊コード編集用に入院基本料加算区分
      *                           の退避
                                  PERFORM   210-GAIHAKU-MAE-SEC
      *
                                  MOVE    1     TO    FLG-RYAKU
                             END-IF
      *
                             MOVE  WRK-KSNKBN
                                         TO  WRK-NYUKHNKSNKBN(IDX1)
                             MOVE  WRK-CHUKSNCD-XXX
                                         TO  WRK-CHUKSNCD(IDX1)
                             MOVE  WRK-NYUKHNKBN-XXX
                                         TO  WRK-NYUKHNKBN(IDX1)
      *
                             MOVE    1    TO   FLG-OK
                           END-IF
                           IF    LNK-NYUINDAY-KBN(IDX1)  =  "1"
                               MOVE    1    TO   FLG-OK
                           END-IF                           
                       END-PERFORM
                   END-IF
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key17"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
               IF   FLG-OK     =   ZERO
                   MOVE     3      TO      LNK-DPCNYUIN-RC
      *            入院会計クローズ
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key17"                 TO  MCP-PATHNAME
                   PERFORM   900-CLOSE-SEC
      *            病棟番号（病棟区分）の編集
                   PERFORM   2105-BTUNUM-HENSHU-SEC
                   GO   TO    200-MAIN-EXT
               END-IF
           ELSE
               MOVE     3      TO      LNK-DPCNYUIN-RC
      *        入院会計クローズ
               MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
               MOVE    "key17"                 TO  MCP-PATHNAME
               PERFORM   900-CLOSE-SEC
      *        病棟番号（病棟区分）の編集
               PERFORM   2105-BTUNUM-HENSHU-SEC
               GO   TO    200-MAIN-EXT
           END-IF
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    入院料の算定が無い日は食事保険をクリア
           PERFORM    VARYING  IDX1   FROM  1  BY  1
             UNTIL    IDX1     >   31
              IF  (WRK-NYUINKHN(IDX1)    =    SPACE)    AND
                  (LNK-NYUINDAY-KBN(IDX1)  =  SPACE)    AND
                  (WRK-NACCT-DAY(IDX1)     =  ZERO)
                   MOVE  ZERO          TO  WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                           WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                           WRK-SKJ-HKNCOMBI-YORU(IDX1)
              END-IF
           END-PERFORM
      *
      *入院時の外泊取得
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "2"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *            外泊区分の退避
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                              UNTIL     IDX1   >   31
                       IF    (WRK-NYUINKHN(IDX1) NOT = SPACE) 
                       AND   (NACCT-DAY(IDX1)    NOT =  ZERO) 
                              PERFORM     210-GAIHAKU-SET-SEC
                       END-IF
                   END-PERFORM
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key17"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *選定療養情報の取得
           MOVE    ZERO                    TO  FLG-SENTEI-SET
           MOVE    ZERO                    TO  FLG-NYUINACCT
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key22"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key22"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *            選定入院の退避
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                              UNTIL     IDX1   >   31
                       IF    (WRK-NYUINKHN(IDX1) NOT = SPACE) 
                       AND   (NACCT-DAY(IDX1)    NOT =  ZERO) 
                           MOVE   NACCT-DAY(IDX1)
                                              TO  TBL-SENTEI (IDX1)
                           MOVE     1         TO  FLG-SENTEI-SET 
                       END-IF
                   END-PERFORM
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key22"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key22"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *老人対象患者チェック
           PERFORM   210-RJN-TAISYO-CHK-SEC
      *
      *食事療養情報の取得（システム管理テーブルより）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-DPCNYUIN-SANTEIYM
                                       TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
      *        食事情報の退避
               PERFORM    VARYING   IDX  FROM  1  BY  1
                          UNTIL     IDX   >    31
      *            入院時食事療養費
                   IF     SYS-5000-SHOKUJIRYOYOCD  NOT =  SPACE
                       MOVE  SYS-5000-SHOKUJIRYOYOCD
                                          TO WRK-SYS5000-SHOKUCD(1 IDX)
                   END-IF
               END-PERFORM
           END-IF
      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食堂加算取得（入院会計より）
           MOVE    ZERO                    TO  KSN-IDX
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  NACCT-SRYYM
           MOVE    "4"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "tbl_nyuinacct"    TO  MCP-TABLE
               MOVE     "key17"            TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                 IF   NACCT-SRYCDTOTAL     =   197000570
      *            入院料加算の退避
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                              UNTIL     IDX1   >   31
                       IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)
                       AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                             (WRK-GAIHAKU-KBN(IDX1) >=  4))
                       AND   (NACCT-DAY(IDX1)    NOT =  ZERO)
      *                  入院時食事療養（１）の場合のみセット
                           IF  WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                          "197000110"
                               MOVE  "197000570"
                                       TO WRK-SYS5000-SHOKUCD(3 IDX1)
                           END-IF
                       END-IF
                   END-PERFORM
                 END-IF
                 MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                 MOVE    "key17"                 TO  MCP-PATHNAME
                 PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *    入院料加算取得（入院会計）
           MOVE    ZERO                    TO  KSN-IDX
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  NACCT-SRYYM
           MOVE    "6"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
             MOVE     "tbl_nyuinacct"      TO  MCP-TABLE
             MOVE     "key17"              TO  MCP-PATHNAME
             PERFORM   910-NYUINACCT-READ-SEC
             PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
              IF       NACCT-ZAIKAISU   NOT =    ZERO
      *        該当入院行為テーブルの読み込み
               PERFORM    210-NYUINACT-GET-SEC
      *        点数マスタより注加算の判定
               INITIALIZE                      TNS-TENSU-REC
               MOVE    LNK-DPCNYUIN-HOSPNUM
                                           TO  TNS-HOSPNUM
               MOVE    NSRY-SRYCD(1)       TO  TNS-SRYCD
               MOVE    LNK-DPCNYUIN-SANTEIYM
                                           TO  TNS-YUKOSTYMD(1:6)
               MOVE    "01"                TO  TNS-YUKOSTYMD(7:2)
               MOVE    TNS-YUKOSTYMD       TO  TNS-YUKOEDYMD
               PERFORM   910-TENSU-READ-SEC
      *        入院料加算の退避
      *
               IF   TNS-CHUKSNCD     =   "0000"
                   ADD    1         TO  IDX-NYUKSN
                   MOVE   NSRY-SRYCD(1)    TO  WRK-NYUKSN-SRYCD-1
                                                      (IDX-NYUKSN)
                   MOVE   NACCT-ZAITEN     TO  WRK-NYUKSN-ZAITEN-1
                                                      (IDX-NYUKSN)
                   PERFORM    VARYING   IDX1   FROM   1   BY   1
                     UNTIL     IDX1   >   31
                        IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                              (LNK-NYUINDAY-KBN(IDX1) = "1"))
                        AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                              (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                        AND   (NACCT-DAY(IDX1)    NOT =  ZERO)
                          MOVE   NACCT-DAY(IDX1)  TO WRK-NYUKSN-DAY-1
                                                      (IDX-NYUKSN IDX1)
                        END-IF
                   END-PERFORM
               ELSE
                 IF ((TNS-CDKBN-KBNNUM   >=   100)   AND
                     (TNS-CDKBN-KBNNUM   <=   199))  OR
                    ((TNS-CDKBN-KBNNUM   >=   300)   AND
                     (TNS-CDKBN-KBNNUM   <=   399))
                      ADD    1         TO  IDX-CHUKSN1
                      MOVE   NSRY-SRYCD(1) TO  WRK-CHUKSN-SRYCD-1
                                                      (IDX-CHUKSN1)
                      MOVE   TNS-CHUKSNCD  TO  WRK-CHUKSN-CHUKSNCD-1
                                                      (IDX-CHUKSN1)
                      MOVE   TNS-CHUKSNTUBAN
                                           TO  WRK-CHUKSN-CHUKSNTUBAN-1
                                                          (IDX-CHUKSN1)
                      MOVE   NACCT-ZAITEN  TO  WRK-CHUKSN-ZAITEN-1
                                                      (IDX-CHUKSN1)
                      PERFORM    VARYING   IDX1   FROM   1   BY   1
                        UNTIL     IDX1   >   31
                          IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                                (LNK-NYUINDAY-KBN(IDX1) = "1"))
                          AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                                (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                          AND   (NACCT-DAY(IDX1)    NOT =  ZERO)
                             MOVE   NACCT-DAY(IDX1)
                                                 TO WRK-CHUKSN-DAY-1
                                                     (IDX-CHUKSN1 IDX1)
                          END-IF
                      END-PERFORM
                 END-IF
      *
                 IF ((TNS-CDKBN-KBNNUM   >=   200)   AND
                     (TNS-CDKBN-KBNNUM   <=   299))
                    ADD    1         TO  IDX-CHUKSN2
                    MOVE   NSRY-SRYCD(1)   TO  WRK-CHUKSN-SRYCD-2
                                                     (IDX-CHUKSN2)
                    MOVE   TNS-CHUKSNCD    TO  WRK-CHUKSN-CHUKSNCD-2
                                                     (IDX-CHUKSN2)
                    MOVE   TNS-CHUKSNTUBAN TO  WRK-CHUKSN-CHUKSNTUBAN-2
                                                          (IDX-CHUKSN2)
                    MOVE   NACCT-ZAITEN    TO  WRK-CHUKSN-ZAITEN-2
                                                          (IDX-CHUKSN2)
                    PERFORM    VARYING   IDX1   FROM   1   BY   1
                      UNTIL     IDX1   >   31
                        IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                              (LNK-NYUINDAY-KBN(IDX1) = "1"))
                        AND  ((WRK-GAIHAKU-KBN(IDX1)  = ZERO) OR
                              (WRK-GAIHAKU-KBN(IDX1)  >=  4))
                        AND   (NACCT-DAY(IDX1)    NOT =  ZERO)
                           MOVE   NACCT-DAY(IDX1)  TO WRK-CHUKSN-DAY-2
                                                     (IDX-CHUKSN2 IDX1)
                        END-IF
                    END-PERFORM
                 END-IF
               END-IF
      *
              END-IF
      *
              MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
              MOVE    "key17"                 TO  MCP-PATHNAME
              PERFORM 910-NYUINACCT-READ-SEC
      *
             END-PERFORM
      *
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *    入院料加算取得（診療会計）
           INITIALIZE                          SRYACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  ACCT-HOSPNUM
           MOVE    "1"                     TO  ACCT-NYUGAIKBN
           MOVE    LNK-DPCNYUIN-PTID       TO  ACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  ACCT-SRYYM
           MOVE    "tbl_sryacct"           TO  MCP-TABLE
           MOVE    "key30"                 TO  MCP-PATHNAME
           PERFORM 910-SRYACCT-SELECT-SEC
           IF      FLG-SRYACCT             =   ZERO
               MOVE    "tbl_sryacct"       TO  MCP-TABLE
               MOVE    "key30"             TO  MCP-PATHNAME
               PERFORM   910-SRYACCT-READ-SEC
               PERFORM   UNTIL   (FLG-SRYACCT    =   1)
                 MOVE      ZERO     TO      FLG-RYAKU
                 IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                      (ACCT-ZAIKAISU  NOT =    ZERO)    AND
                      (ACCT-ZAIKBN    =        ZERO)
                   IF   ACCT-SRYKBN  =  "90" OR "92"
                     INITIALIZE      SRYACT-REC
                     MOVE    ACCT-HOSPNUM   TO   SRY-HOSPNUM
                     MOVE    ACCT-NYUGAIKBN TO   SRY-NYUGAIKBN
                     MOVE    ACCT-PTID      TO   SRY-PTID
                     MOVE    ACCT-SRYKA     TO   SRY-SRYKA
                     MOVE    ACCT-SRYYM     TO   SRY-SRYYM
                     MOVE    ACCT-ZAINUM    TO   SRY-ZAINUM
                     MOVE    1              TO   SRY-RENNUM
                     MOVE    "tbl_sryact"   TO  MCP-TABLE
                     MOVE    "key"          TO  MCP-PATHNAME
                     PERFORM 910-SRYACT-SELECT-SEC
                     IF      FLG-SRYACT     =    ZERO
                         MOVE     "tbl_sryact"   TO  MCP-TABLE
                         MOVE     "key"          TO  MCP-PATHNAME
                         PERFORM   910-SRYACT-READ-SEC
                         IF  FLG-SRYACT    =    ZERO
      *                    点数マスタより注加算の判定
                           INITIALIZE                TNS-TENSU-REC
                           MOVE    LNK-DPCNYUIN-HOSPNUM
                                                 TO  TNS-HOSPNUM
                           MOVE    SRY-SRYCD(1)  TO  TNS-SRYCD
                           MOVE    LNK-DPCNYUIN-SANTEIYM
                                                 TO  TNS-YUKOSTYMD(1:6)
                           MOVE    "01"          TO  TNS-YUKOSTYMD(7:2)
                           MOVE    TNS-YUKOSTYMD TO  TNS-YUKOEDYMD
                           PERFORM   910-TENSU-READ-SEC
                         END-IF
                     END-IF
      *              診療行為クローズ
                     MOVE     "tbl_sryact"   TO  MCP-TABLE
                     MOVE     "key"          TO  MCP-PATHNAME
                     PERFORM   900-CLOSE-SEC
      *             入院料加算の退避
                    IF  TNS-CHUKSNCD         =   "0000"
                       ADD    1              TO  IDX-NYUKSN
                       MOVE   SRY-SRYCD(1)   TO  WRK-NYUKSN-SRYCD-1
                                                        (IDX-NYUKSN)
                       MOVE   ACCT-ZAITEN    TO  WRK-NYUKSN-ZAITEN-1
                                                        (IDX-NYUKSN)
                       PERFORM    VARYING   IDX1   FROM   1   BY   1
                         UNTIL     IDX1   >   31
                         IF  ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                              (LNK-NYUINDAY-KBN(IDX1) = "1"))
                         AND ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR 
                              (WRK-GAIHAKU-KBN(IDX1)  >=  4))
                         AND  (ACCT-DAY(1 IDX1)    NOT =  ZERO)
                           MOVE   ACCT-DAY(1 IDX1)  TO WRK-NYUKSN-DAY-1
                                                      (IDX-NYUKSN IDX1)
                         END-IF
                       END-PERFORM
                    ELSE
      *
                      IF ((TNS-CDKBN-KBNNUM   >=   100)   AND
                          (TNS-CDKBN-KBNNUM   <=   199))  OR
                         ((TNS-CDKBN-KBNNUM   >=   300)   AND
                          (TNS-CDKBN-KBNNUM   <=   399))
                         ADD    1         TO  IDX-CHUKSN1
                         MOVE   SRY-SRYCD(1)
                                           TO  WRK-CHUKSN-SRYCD-1
                                                          (IDX-CHUKSN1)
                         MOVE   TNS-CHUKSNCD
                                           TO  WRK-CHUKSN-CHUKSNCD-1
                                                          (IDX-CHUKSN1)
                         MOVE   TNS-CHUKSNTUBAN
                                           TO  WRK-CHUKSN-CHUKSNTUBAN-1
                                                          (IDX-CHUKSN1)
                         MOVE   ACCT-ZAITEN
                                           TO  WRK-CHUKSN-ZAITEN-1
                                                          (IDX-CHUKSN1)
                         PERFORM    VARYING   IDX1   FROM   1   BY   1
                           UNTIL     IDX1   >   31
                            IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                                  (LNK-NYUINDAY-KBN(IDX1) = "1"))
                            AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                                  (WRK-GAIHAKU-KBN(IDX1)  >=  4))
                            AND   (ACCT-DAY(1 IDX1)    NOT =  ZERO)
                              MOVE   ACCT-DAY(1 IDX1)
                                                  TO  WRK-CHUKSN-DAY-1
                                                     (IDX-CHUKSN1 IDX1)
                            END-IF
                         END-PERFORM
                      END-IF
      *
                      IF ((TNS-CDKBN-KBNNUM   >=   200)   AND
                          (TNS-CDKBN-KBNNUM   <=   299))
                         ADD    1         TO  IDX-CHUKSN2
                         MOVE   SRY-SRYCD(1)
                                           TO  WRK-CHUKSN-SRYCD-2
                                                          (IDX-CHUKSN2)
                         MOVE   TNS-CHUKSNCD
                                           TO  WRK-CHUKSN-CHUKSNCD-2
                                                          (IDX-CHUKSN2)
                         MOVE   TNS-CHUKSNTUBAN
                                           TO  WRK-CHUKSN-CHUKSNTUBAN-2
                                                          (IDX-CHUKSN2)
                         MOVE   ACCT-ZAITEN
                                           TO  WRK-CHUKSN-ZAITEN-2
                                                          (IDX-CHUKSN2)
                         PERFORM    VARYING   IDX1   FROM   1   BY   1
                           UNTIL     IDX1   >   31
                            IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                                  (LNK-NYUINDAY-KBN(IDX1) = "1"))
                            AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                                  (WRK-GAIHAKU-KBN(IDX1)  >=   4))
                            AND   (ACCT-DAY(1 IDX1)    NOT =  ZERO)
                              MOVE   ACCT-DAY(1 IDX1)
                                                  TO  WRK-CHUKSN-DAY-2
                                                     (IDX-CHUKSN2 IDX1)
                            END-IF
                         END-PERFORM
                      END-IF
      *
      *               医療観察の加算手入力分
                      IF   SRY-SRYCD(1)(1:3)    =     "188"
                         PERFORM    VARYING   IDX1   FROM   1   BY   1
                           UNTIL     IDX1   >   31
                            IF   ((WRK-NYUINKHN(IDX1) NOT = SPACE)  OR
                                  (LNK-NYUINDAY-KBN(IDX1) = "1"))
                            AND  ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                                  (WRK-GAIHAKU-KBN(IDX1) >=   4))
                            AND   (ACCT-DAY(1 IDX1)    NOT =  ZERO)
                            AND   (ACCT-HKNCOMBI  =
                                                WRK-HKNCOMBI-DAY(IDX1))
                               MOVE   SRY-SRYCD(1)  TO
                                            WRK-IRYOKNS-SRYCD5(IDX1)
                               MOVE   "1"           TO
                                            WRK-IRYOKNS-SORT-FLG(IDX1)
                            END-IF
                         END-PERFORM
                      END-IF
      *
      *
                    END-IF
      *
                   END-IF
                 END-IF
                 MOVE     "tbl_sryacct"      TO  MCP-TABLE
                 MOVE     "key30"            TO  MCP-PATHNAME
                 PERFORM   910-SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *    診療会計クローズ
           MOVE     "tbl_sryacct"   TO  MCP-TABLE
           MOVE     "key30"          TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *    取得した入院料加算を注加算コード、注加算通番順に並び替え
           PERFORM      VARYING    IDX-CHUKSN1   FROM   1  BY  1
             UNTIL     (IDX-CHUKSN1   >   50)   OR
                       (WRK-CHUKSN-SRYCD-1(IDX-CHUKSN1)  =   SPACE)
               COMPUTE   IDX-CHUKSN1SS   =   IDX-CHUKSN1  +  1
               PERFORM   VARYING IDX-CHUKSN1S FROM IDX-CHUKSN1SS  BY  1
                 UNTIL   (IDX-CHUKSN1S   >   50)   OR
                         (WRK-CHUKSN-SRYCD-1(IDX-CHUKSN1S) =  SPACE)
                   IF  WRK-CHUKSN-CHUCD-1(IDX-CHUKSN1)
                                   <=  WRK-CHUKSN-CHUCD-1(IDX-CHUKSN1S)
                       CONTINUE
                   ELSE
                       MOVE   WRK-CHUKSN-TBL-1(IDX-CHUKSN1)
                                      TO   WRK-CHUKSN-TAIHI
                       MOVE   WRK-CHUKSN-TBL-1(IDX-CHUKSN1S)
                                      TO  WRK-CHUKSN-TBL-1(IDX-CHUKSN1)
                       MOVE   WRK-CHUKSN-TAIHI
                                      TO  WRK-CHUKSN-TBL-1(IDX-CHUKSN1S)
                   END-IF
               END-PERFORM
           END-PERFORM
           PERFORM      VARYING    IDX-CHUKSN2   FROM   1  BY  1
             UNTIL     (IDX-CHUKSN2   >   50)   OR
                       (WRK-CHUKSN-SRYCD-2(IDX-CHUKSN2)  =   SPACE)
               COMPUTE   IDX-CHUKSN2SS   =   IDX-CHUKSN2  +  1
               PERFORM   VARYING IDX-CHUKSN2S FROM IDX-CHUKSN2SS  BY  1
                 UNTIL   (IDX-CHUKSN2S   >   50)   OR
                         (WRK-CHUKSN-SRYCD-2(IDX-CHUKSN2S) =  SPACE)
                   IF  WRK-CHUKSN-CHUCD-2(IDX-CHUKSN2)
                                   <=  WRK-CHUKSN-CHUCD-2(IDX-CHUKSN2S)
                       CONTINUE
                   ELSE
                       MOVE   WRK-CHUKSN-TBL-2(IDX-CHUKSN2)
                                      TO   WRK-CHUKSN-TAIHI
                       MOVE   WRK-CHUKSN-TBL-2(IDX-CHUKSN2S)
                                      TO  WRK-CHUKSN-TBL-2(IDX-CHUKSN2)
                       MOVE   WRK-CHUKSN-TAIHI
                                      TO  WRK-CHUKSN-TBL-2(IDX-CHUKSN2S)
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *
      *    医療観察で手入力された加算（転院調整加算）がある場合に並び替え
      *    注加算通番のセット
           PERFORM      VARYING    IDX1   FROM   1  BY  1
             UNTIL      IDX1      >   31
               IF   WRK-IRYOKNS-SORT-FLG(IDX1)  =   "1"
                    PERFORM     VARYING  IDX2   FROM  1 BY 1
                      UNTIL     IDX2  >  5
                      IF  WRK-IRYOKNS-SRYCD(IDX1 IDX2) NOT = SPACE
      *                 点数マスタより注加算通番のセット
                        INITIALIZE                TNS-TENSU-REC
                        MOVE    LNK-DPCNYUIN-HOSPNUM
                                              TO  TNS-HOSPNUM
                        MOVE    WRK-IRYOKNS-SRYCD(IDX1 IDX2)
                                              TO  TNS-SRYCD
                        MOVE    LNK-DPCNYUIN-SANTEIYM
                                              TO TNS-YUKOSTYMD(1:6)
                        MOVE    "01"          TO TNS-YUKOSTYMD(7:2)
                        MOVE    TNS-YUKOSTYMD TO  TNS-YUKOEDYMD
                        PERFORM   910-TENSU-READ-SEC
                        MOVE    TNS-CHUKSNTUBAN
                                            TO  WRK-IRYOKNS-CHUKSNTUBAN
                                                       (IDX1 IDX2)
                      END-IF
                    END-PERFORM
               END-IF
           END-PERFORM
      *    注加算通番の並び替え
           PERFORM      VARYING    IDX1   FROM   1  BY  1
             UNTIL      IDX1      >   31
               IF  WRK-IRYOKNS-SORT-FLG(IDX1)  =   "1"
                   PERFORM     VARYING  IDX2   FROM  1 BY 1
                     UNTIL     IDX2  >  4
                     COMPUTE   IDX4   =    IDX2   +   1
                     PERFORM   VARYING   IDX3  FROM  IDX4  BY  1
                       UNTIL   IDX3    >  5
                       IF (WRK-IRYOKNS-SRYCD(IDX1 IDX2) NOT = SPACE) AND
                          (WRK-IRYOKNS-SRYCD(IDX1 IDX3) NOT = SPACE)
                           IF  WRK-IRYOKNS-CHUKSNTUBAN(IDX1 IDX2)
                                 <=  WRK-IRYOKNS-CHUKSNTUBAN(IDX1 IDX3)
                               CONTINUE
                           ELSE
                              MOVE  WRK-IRYOKNS-SRYCD-OCC(IDX1 IDX2)
                                           TO  WRK-IRYOKNS-TAIHI
                              MOVE  WRK-IRYOKNS-SRYCD-OCC(IDX1 IDX3)
                                           TO
                                        WRK-IRYOKNS-SRYCD-OCC(IDX1 IDX2)
                              MOVE  WRK-IRYOKNS-TAIHI
                                           TO
                                        WRK-IRYOKNS-SRYCD-OCC(IDX1 IDX3)
                           END-IF
                       END-IF
                     END-PERFORM
                   END-PERFORM
               END-IF
           END-PERFORM
      *
      *
      *    取得した入院情報から日単位の入院会計情報を再構築
           PERFORM      VARYING    IDX1   FROM   1  BY  1
                        UNTIL      IDX1   >   31
      *        診療区分
               MOVE   WRK-SRYKBN(IDX1)  TO  WRK-SO-SRYKBN(IDX1)
               IF    (LNK-NYUINDAY-KBN(IDX1)   =    "1")   AND
                     (LNK-NYUINDAY-TANKI2-KBN(IDX1)  NOT =    SPACE)
                   MOVE   "92"     TO       WRK-SO-SRYKBN(IDX1)
               END-IF
               IF    (LNK-NYUINDAY-KBN(IDX1)   =    "1")   AND
                     (LNK-NYUINDAY-TANKI2-KBN(IDX1)  =    SPACE)  AND
                     (WRK-NYUINKHN(IDX1)             =    SPACE)
                   MOVE   "90"     TO       WRK-SO-SRYKBN(IDX1)
               END-IF
      *        保険組合せ
               MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                        TO  WRK-SO-HKNCOMBI-DAY(IDX1)
      *
               MOVE     ZERO                TO  WRK-MEISAISU
      *
      *        入院基本料
               IF         WRK-NYUINKHN(IDX1)  NOT =        SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-NYUINKHN(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
                   IF     FLG-SENTEI-SET    NOT =   ZERO
                       IF   TBL-SENTEI(IDX1)    =   1
                           MOVE    ZERO    TO  FLG-SENTEICDCHG
                           INITIALIZE  SENTEICDCHG-REC
                           MOVE    WRK-NYUINKHN(IDX1)
                                           TO  SENCHG-IPNSRYCD
                           MOVE     "tbl_senteicdchg"  TO  MCP-TABLE
                           MOVE     "key2"             TO  MCP-PATHNAME
                           PERFORM   910-SENTEICDCHG-SELECT-SEC
                           IF      FLG-SENTEICDCHG  =    ZERO
                               MOVE     "tbl_senteicdchg"
                                                      TO  MCP-TABLE
                               MOVE     "key2"        TO  MCP-PATHNAME
                               PERFORM  910-SENTEICDCHG-READ-SEC
                               IF    FLG-SENTEICDCHG  =   ZERO
                                  IF    WRK-NYUINKHN(IDX1)  NOT =
                                                   SENCHG-SENTEISRYCD
                                       MOVE  SENCHG-SENTEISRYCD
                                                TO  WRK-SO-SRYCD
                                                   (IDX1 WRK-MEISAISU)
                                  ELSE
      *                               夜勤時間超過減算の選定処理
                                      IF  LNK-DPCNYUIN-SANTEIYM
                                                      >=    "201404"
                                        ADD    1      TO  WRK-MEISAISU
                                        MOVE  "190122890"
                                                TO  WRK-SO-SRYCD
                                                   (IDX1 WRK-MEISAISU)
                                      END-IF
                                  END-IF
                               END-IF
                          END-IF
                          MOVE     "tbl_senteicdchg"   TO  MCP-TABLE
                          MOVE     "key2"              TO  MCP-PATHNAME
                         PERFORM   900-CLOSE-SEC
                       END-IF
                   END-IF
               END-IF
      *
      *        夜間看護体制特定日減算
               IF         WRK-KANGOGEN(IDX1)  NOT =        SPACE
                   ADD      1                TO  WRK-MEISAISU
                   MOVE   WRK-KANGOGEN(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
      *
      *        医療観察
               IF         WRK-IRYOKNS-SRYCD1(IDX1)  NOT =   SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-IRYOKNS-SRYCD1(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
               IF         WRK-IRYOKNS-SRYCD2(IDX1)  NOT =   SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-IRYOKNS-SRYCD2(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
               IF         WRK-IRYOKNS-SRYCD3(IDX1)  NOT =   SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-IRYOKNS-SRYCD3(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
               IF         WRK-IRYOKNS-SRYCD4(IDX1)  NOT =   SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-IRYOKNS-SRYCD4(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
               IF         WRK-IRYOKNS-SRYCD5(IDX1)  NOT =   SPACE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-IRYOKNS-SRYCD5(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
      *
      *        他医療機関受診（３０％減算と７０％減算）
      *        特定時間退院減算
      *        特定曜日入退院減算
               IF     ((WRK-GAIHAKU(IDX1)        =
                                    "190142190" OR  "190142090" OR
                                    "190142290" OR  "190141590" OR
                                    "190108790" OR  "190108890" OR
                                    "190109090" OR
                                    "190153190" OR  "190153090" OR
                                    "190153390" OR  "190153290" OR
                                    "190161470" OR  "190161570" OR
                                    "190161670" OR  "190161770" OR
                                    "190161870" OR  "190161970" OR
                                    "190162070" OR  "190162170" OR
                                    "190182990" OR
                                    "190198570" OR  "190198670" OR
                                    "190213790" OR  "190214290" OR
                                    "190213890" OR  "190214090" OR
                                    "190214390" OR  "190213990" OR
                                    "190214190"                 )  OR
                       (WRK-GAIHAKU2(IDX1)       =
                                    "190108890" OR  "190142190" OR
                                    "190141590" OR  "190213790"))
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-GAIHAKU(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
                   IF        (WRK-NYUINKHN(IDX1)  NOT =   SPACE)
                   AND       (WRK-GAIHAKU2(IDX1)  NOT =   SPACE)
                       ADD      1               TO  WRK-MEISAISU
                       MOVE   WRK-GAIHAKU2(IDX1) TO  WRK-SO-SRYCD
                                               (IDX1 WRK-MEISAISU)
                   END-IF
               END-IF
      *
      *        初期加算（長期減算）
               IF     ((WRK-GAIHAKU(IDX1)       =   SPACE       OR
                                    "190142190" OR  "190142090" OR
                                    "190142290" OR  "190141590" OR
                                    "190108790" OR  "190108890" OR
                                    "190109090" OR
                                    "190153190" OR  "190153090" OR
                                    "190153390" OR  "190153290" OR
                                    "190161470" OR  "190161570" OR
                                    "190161670" OR  "190161770" OR
                                    "190161870" OR  "190161970" OR
                                    "190162070" OR  "190162170" OR
                                    "190182990" OR
                                    "190198570" OR  "190198670" OR
                                    "190213790" OR  "190214290" OR
                                    "190213890" OR  "190214090" OR
                                    "190214390" OR  "190213990" OR
                                    "190214190"                 )  OR
                       (WRK-GAIHAKU2(IDX1)       =
                                    "190108890" OR  "190142190" OR
                                    "190141590" OR  "190213790"))
               AND     (WRK-SHOKIKSN(IDX1)      NOT =   SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-SHOKIKSN(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
      *
      *        標欠
               IF     ((WRK-GAIHAKU(IDX1)       =   SPACE       OR
                                    "190142190" OR  "190142090" OR
                                    "190142290" OR  "190141590" OR
                                    "190108790" OR  "190108890" OR
                                    "190109090" OR
                                    "190153190" OR  "190153090" OR
                                    "190153390" OR  "190153290" OR
                                    "190161470" OR  "190161570" OR
                                    "190161670" OR  "190161770" OR
                                    "190161870" OR  "190161970" OR
                                    "190162070" OR  "190162170" OR
                                    "190182990" OR
                                    "190198570" OR  "190198670" OR
                                    "190213790" OR  "190214290" OR
                                    "190213890" OR  "190214090" OR
                                    "190214390" OR  "190213990" OR
                                    "190214190"                 )  OR
                       (WRK-GAIHAKU2(IDX1)       =
                                    "190108890" OR  "190142190" OR
                                    "190141590" OR  "190213790"))
               AND     (WRK-HYOUKETSU(IDX1)   NOT =         SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-HYOUKETSU(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
      *
      *        定数超過
               IF     ((WRK-GAIHAKU(IDX1)       =   SPACE       OR
                                    "190142190" OR  "190142090" OR
                                    "190142290" OR  "190141590" OR
                                    "190108790" OR  "190108890" OR
                                    "190109090" OR
                                    "190153190" OR  "190153090" OR
                                    "190153390" OR  "190153290" OR
                                    "190161470" OR  "190161570" OR
                                    "190161670" OR  "190161770" OR
                                    "190161870" OR  "190161970" OR
                                    "190162070" OR  "190162170" OR
                                    "190182990" OR
                                    "190198570" OR  "190198670" OR
                                    "190213790" OR  "190214290" OR
                                    "190213890" OR  "190214090" OR
                                    "190214390" OR  "190213990" OR
                                    "190214190"                 )  OR
                       (WRK-GAIHAKU2(IDX1)       =
                                    "190108890" OR  "190142190" OR
                                    "190141590" OR  "190213790"))
               AND     (WRK-TEISU(IDX1)       NOT =         SPACE)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-TEISU(IDX1)  TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
               END-IF
      *
      *        外泊
               IF         WRK-GAIHAKU(IDX1)   NOT =        SPACE
                 IF     ((WRK-GAIHAKU(IDX1)     =
                                    "190142190" OR  "190142090" OR
                                    "190142290" OR  "190141590" OR
                                    "190108790" OR  "190108890" OR
                                    "190109090" OR
                                    "190153190" OR  "190153090" OR
                                    "190153390" OR  "190153290" OR
                                    "190161470" OR  "190161570" OR
                                    "190161670" OR  "190161770" OR
                                    "190161870" OR  "190161970" OR
                                    "190162070" OR  "190162170" OR
                                    "190182990" OR
                                    "190198570" OR  "190198670" OR
                                    "190213790" OR  "190214290" OR
                                    "190213890" OR  "190214090" OR
                                    "190214390" OR  "190213990" OR
                                    "190214190"                 )  OR
                       (WRK-GAIHAKU2(IDX1)       =
                                    "190108890" OR  "190142190" OR
                                    "190141590" OR  "190213790"))
                          CONTINUE
                 ELSE
                   ADD      1               TO  WRK-MEISAISU
                   MOVE   WRK-GAIHAKU(IDX1) TO  WRK-SO-SRYCD
                                           (IDX1 WRK-MEISAISU)
                   MOVE   WRK-GAIHAKU-KBN(IDX1)
                                            TO  WRK-SO-GAIHAKU-KBN
                                                           (IDX1 IDX1)
                 END-IF
               END-IF
      *
      *
      *        入院料加算セット（Ａ１００番台、Ａ３００番台）
               PERFORM    VARYING   IDX-CHUKSN1  FROM  1   BY  1
                 UNTIL    (IDX-CHUKSN1    >   50)    OR
                          (WRK-CHUKSN-SRYCD-1(IDX-CHUKSN1)  =  SPACE)
                   IF    WRK-CHUKSN-DAY-1(IDX-CHUKSN1 IDX1)  =  ZERO
                       CONTINUE
                   ELSE
                       ADD   1    TO  WRK-MEISAISU
                       MOVE  WRK-CHUKSN-SRYCD-1(IDX-CHUKSN1)
                                  TO  WRK-SO-SRYCD(IDX1 WRK-MEISAISU)
                   END-IF
               END-PERFORM
      *
      *        入院料加算セット（Ａ２００番台）
               PERFORM    VARYING   IDX-CHUKSN2  FROM  1   BY  1
                 UNTIL    (IDX-CHUKSN2    >   50)    OR
                          (WRK-CHUKSN-SRYCD-2(IDX-CHUKSN2)  =  SPACE)
                   IF    WRK-CHUKSN-DAY-2(IDX-CHUKSN2 IDX1)  =  ZERO
                       CONTINUE
                   ELSE
                       ADD   1    TO  WRK-MEISAISU
                       MOVE  WRK-CHUKSN-SRYCD-2(IDX-CHUKSN2)
                                  TO  WRK-SO-SRYCD(IDX1 WRK-MEISAISU)
                   END-IF
               END-PERFORM
      *
      *        その他入院料加算セット
               PERFORM   VARYING   IDX-NYUKSN   FROM   1  BY   1
                 UNTIL  (IDX-NYUKSN    >     50)    OR
                        (WRK-NYUKSN-SRYCD-1(IDX-NYUKSN)  =  SPACE)
                  IF    WRK-NYUKSN-DAY-1(IDX-NYUKSN IDX1)  =  ZERO
                      CONTINUE
                  ELSE
                      ADD   1    TO  WRK-MEISAISU
                      MOVE  WRK-NYUKSN-SRYCD-1(IDX-NYUKSN)
                                 TO  WRK-SO-SRYCD(IDX1 WRK-MEISAISU)
                  END-IF
               END-PERFORM
      *
      *
      *        選定入院時の外泊
               IF   (TBL-SENTEI(IDX1)    =         1)   AND
                    (WRK-GAIHAKU-KBN(IDX1)     NOT =  ZERO)
                   EVALUATE   WRK-GAIHAKU-KBN(IDX1)
      *                外泊
                       WHEN   3
      *            AZU-MOD START 2015.6.10
      *            選定入院時の外泊もレコード記録するように対処
                           IF    LNK-DPCNYUIN-SANTEIYM  <=  "201503"
                              INITIALIZE   WRK-NYUIN-SORT-TBL(IDX1)
                           ELSE
                              MOVE  1   TO  WRK-SENTEI-GAIGAKU(IDX1)
                           END-IF
      *            AZU-MOD END 2015.6.10
      *                他医療機関受診
                       WHEN   4
      ******                 WHEN   5
                           INITIALIZE   WRK-NYUIN-SORT-TBL(IDX1)
                   END-EVALUATE
               END-IF
      *
      *        医療区分、ＡＤＬ点数コメント（平成２８年１０月診療分以降）
               IF     LNK-DPCNYUIN-SANTEIYM       >=  "201610"
                 IF     LNK-RYOCOM-NYUINKBN(IDX1)    =   "1"
                   PERFORM    VARYING  IDX-COM  FROM  1  BY  1
                     UNTIL   (IDX-COM    >   30)   OR
                             (LNK-RYOCOM-IRYO-SRYCD(IDX1 IDX-COM) =
                                                             SPACE)
                       ADD    1             TO  WRK-MEISAISU
                       MOVE     LNK-RYOCOM-IRYO-SRYCD(IDX1 IDX-COM)
                                            TO  WRK-SO-SRYCD
                                                (IDX1 WRK-MEISAISU)
                   END-PERFORM
                   ADD      1               TO  WRK-MEISAISU
                   MOVE     LNK-RYOCOM-ADL-SRYCD-H28(IDX1 1)
                                            TO  WRK-SO-SRYCD
                                                (IDX1 WRK-MEISAISU)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE     LNK-RYOCOM-ADL-SRYCD-H28(IDX1 2)
                                            TO  WRK-SO-SRYCD
                                                (IDX1 WRK-MEISAISU)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE     LNK-RYOCOM-ADL-SRYCD-H28(IDX1 3)
                                            TO  WRK-SO-SRYCD
                                                (IDX1 WRK-MEISAISU)
                   ADD      1               TO  WRK-MEISAISU
                   MOVE     LNK-RYOCOM-ADL-SRYCD-H28(IDX1 4)
                                            TO  WRK-SO-SRYCD
                                                (IDX1 WRK-MEISAISU)
                 END-IF
               END-IF
      *
           END-PERFORM
      *
      *    再構築した入院会計情報から点数の算定
           PERFORM      VARYING    IDX1   FROM   1  BY  1
                        UNTIL      IDX1   >   31
      *        点数マスタの読み込み
               PERFORM   VARYING   IDX2    FROM   1  BY   1
                         UNTIL (WRK-SO-SRYCD(IDX1 IDX2) = SPACE)
                            OR (IDX2    >      50)
                   PERFORM    210-TENSU-KEISAN-SEC
               END-PERFORM
           END-PERFORM
      *
      **     PERFORM    VARYING   IDX1   FROM  1  BY  1
      **                UNTIL     (IDX1   >     31)
      **          DISPLAY  "IDX1 = " IDX1
      **          DISPLAY  "WRK-SO-HKNCOMBI-DAY = " WRK-SO-HKNCOMBI-DAY
      **                                                         (IDX1)
      **          DISPLAY  "WRK-SO-SRYKBN   = " WRK-SO-SRYKBN(IDX1)
      **          DISPLAY  "WRK-SO-MEISAISU = " WRK-SO-MEISAISU(IDX1)
      **          DISPLAY  "WRK-SO-SRYCD(1) = " WRK-SO-SRYCD(IDX1 1)
      **          DISPLAY  "WRK-SO-SRYCD(2) = " WRK-SO-SRYCD(IDX1 2)
      **          DISPLAY  "WRK-SO-SRYCD(3) = " WRK-SO-SRYCD(IDX1 3)
      **          DISPLAY  "WRK-SO-SRYCD(4) = " WRK-SO-SRYCD(IDX1 4)
      **          DISPLAY  "WRK-SO-SRYCD(5) = " WRK-SO-SRYCD(IDX1 5)
      **          DISPLAY  "WRK-SO-SRYCDTOTAL = " WRK-SO-SRYCDTOTAL(IDX1)
      **          DISPLAY  "WRK-SO-TEN      = " WRK-SO-TEN(IDX1)
      **          DISPLAY  "WRK-SO-KAISU    = " WRK-SO-KAISU(IDX1)
      **     END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへのセット（入院料　診療区分９０）
           MOVE       ZERO      TO     IDX2
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
               IF   (WRK-SO-MEISAISU(IDX1)  NOT =   ZERO)   AND
      *AZU-DEL START 2015.6.10
      **            (WRK-SO-TEN(IDX1)       NOT =   ZERO)   AND
      *AZU-DEL END 2015.6.10
                    (WRK-SO-SRYKBN(IDX1)    =       "90")
                     MOVE  IDX1   TO    IDX2
                     MOVE  WRK-SO-HKNCOMBI-DAY(IDX1) TO
                                     LNK-DPCNYUIN-HKNCOMBI(1 IDX2)
                     MOVE  WRK-SO-MEISAISU(IDX1)   TO
                                     LNK-DPCNYUIN-MEISAISU(1 IDX2)
                     PERFORM   VARYING   IDX3   FROM   1   BY  1
                               UNTIL (WRK-SO-SRYCD(IDX1 IDX3) = SPACE)
                                  OR (IDX3   >   50)
                         MOVE   "SI"   TO
                                    LNK-DPCNYUIN-RECSKB(1 IDX2 IDX3)
      **                   IF    IDX3   =    1
                               MOVE   WRK-SO-SRYKBN(IDX1)  TO   
                                    LNK-DPCNYUIN-SRYSKB(1 IDX2 IDX3)
      **                   END-IF
                         MOVE  WRK-SO-SRYCD(IDX1 IDX3) TO
                                    LNK-DPCNYUIN-SRYCD(1 IDX2 IDX3)
      *AZU-ADD START 2015.6.10
                         IF  (WRK-SO-SRYCD(IDX1 IDX3) = "190107290") AND
                             (WRK-SENTEI-GAIGAKU(IDX1) = 1)
                            MOVE  1  TO
                               LNK-DPCNYUIN-SENTEI-GAIHAKU(1 IDX2 IDX3)
                         END-IF
      *AZU-ADD END 2015.6.10
                         MOVE  ZERO     TO    IDX4
                         COMPUTE   IDX4 =    IDX3   +   1
                         IF    WRK-SO-SRYCD(IDX1 IDX4)    =   SPACE
                               MOVE   WRK-SO-TEN(IDX1)   TO
                                      LNK-DPCNYUIN-TEN(1 IDX2 IDX3)
                               MOVE   WRK-SO-KAISU(IDX1)   TO
                                     LNK-DPCNYUIN-KAISU(1 IDX2 IDX3)
                         END-IF
                     END-PERFORM
               END-IF
           END-PERFORM
      *    レセ電サブ返却エリアへのセット（特定入院料　診療区分９２）
           MOVE      ZERO     TO   IDX2
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
               IF   (WRK-SO-MEISAISU(IDX1)  NOT =   ZERO)   AND
                    (WRK-SO-TEN(IDX1)       NOT =   ZERO)   AND
                    (WRK-SO-SRYKBN(IDX1)    =       "92")
                     MOVE   IDX1     TO    IDX2
                     MOVE  WRK-SO-HKNCOMBI-DAY(IDX1) TO
                                     LNK-DPCNYUIN-HKNCOMBI(2 IDX2)
                     MOVE  WRK-SO-MEISAISU(IDX1)   TO
                                     LNK-DPCNYUIN-MEISAISU(2 IDX2)
                     PERFORM   VARYING   IDX3   FROM   1   BY  1
                               UNTIL (WRK-SO-SRYCD(IDX1 IDX3) = SPACE)
                                  OR (IDX3   >   50)
                         MOVE   "SI"   TO   
                                    LNK-DPCNYUIN-RECSKB(2 IDX2 IDX3)
      **                   IF    IDX3   =    1
                               MOVE   WRK-SO-SRYKBN(IDX1)  TO   
                                    LNK-DPCNYUIN-SRYSKB(2 IDX2 IDX3)
      **                   END-IF
                         MOVE  WRK-SO-SRYCD(IDX1 IDX3) TO
                                    LNK-DPCNYUIN-SRYCD(2 IDX2 IDX3)
                         MOVE  ZERO     TO    IDX4
                         COMPUTE   IDX4 =    IDX3   +   1
                         IF    WRK-SO-SRYCD(IDX1 IDX4)    =    SPACE
                               MOVE   WRK-SO-TEN(IDX1)   TO
                                      LNK-DPCNYUIN-TEN(2 IDX2 IDX3)
                               MOVE   WRK-SO-KAISU(IDX1)   TO
                                     LNK-DPCNYUIN-KAISU(2 IDX2 IDX3)
                         END-IF
                     END-PERFORM
                END-IF
           END-PERFORM
      *
      *    食事情報の編集
           IF    LNK-DPCNYUIN-SANTEIYM  <=  "201603"
               PERFORM   2103-SHOKUJI-HENSHU3-SEC
           ELSE
               IF    LNK-DPCNYUIN-SANTEIYM  <=  "201709"
                   PERFORM   2103-SHOKUJI-HENSHU4-SEC
               ELSE
                   PERFORM   2103-SHOKUJI-HENSHU5-SEC
               END-IF
           END-IF
      *
      *    入院時生活療養（環境療養）の編集
           IF  (LNK-DPCNYUIN-SANTEIYM  >=  "200610")  AND
               (LNK-DPCNYUIN-SANTEIYM  <=  "201603")
               IF  LNK-NYULIFE-RC         =    ZERO
                   PERFORM   2104-KANKYO-HENSHU-SEC
               END-IF
           END-IF
      *
      *    入院時生活療養（環境療養）の編集
           IF  (LNK-DPCNYUIN-SANTEIYM  >=  "201604")  AND
               (LNK-DPCNYUIN-SANTEIYM  <=  "201709")  AND
               (LNK-NYULIFE2-RC         =    ZERO)
               PERFORM   2104-KANKYO-HENSHU2-SEC
           END-IF
      *
      *    入院時生活療養（環境療養）の編集
           IF  (LNK-DPCNYUIN-SANTEIYM  >=  "201710")  AND
               (LNK-NYULIFE2-RC         =    ZERO)
               PERFORM   2104-KANKYO-HENSHU3-SEC
           END-IF
      *
      *    病棟番号（病棟区分）の編集
           PERFORM   2105-BTUNUM-HENSHU-SEC
      *
      *    生活療養食事テスト表示
      **     DISPLAY "==SEIKATSU-SOKUJI=="
      **     PERFORM    VARYING   IDX1   FROM  1  BY  1
      **                UNTIL     (IDX1   >     31)
      **          DISPLAY  "IDX1 = " IDX1
      **          DISPLAY  "SRYCD,TEN,KAISU(1) = " 
      **                                     LNK-DPCNYUIN-SRYCD(4 IDX1 1)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(4 IDX1 1)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(4 IDX1 1)
      **          DISPLAY  "SRYCD,TEN,KAISU(2) = " 
      **                                     LNK-DPCNYUIN-SRYCD(4 IDX1 2)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(4 IDX1 2)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(4 IDX1 2)
      **          DISPLAY  "SRYCD,TEN,KAISU(3) = " 
      **                                     LNK-DPCNYUIN-SRYCD(4 IDX1 3)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(4 IDX1 3)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(4 IDX1 3)
      **     END-PERFORM
      *    生活療養居住費テスト表示
      **     DISPLAY "==SEIKATSU-SOKUJI=="
      **     PERFORM    VARYING   IDX1   FROM  1  BY  1
      **                UNTIL     (IDX1   >     31)
      **          DISPLAY  "IDX1 = " IDX1
      **          DISPLAY  "SRYCD,TEN,KAISU(1) = " 
      **                                     LNK-DPCNYUIN-SRYCD(5 IDX1 1)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(5 IDX1 1)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(5 IDX1 1)
      **          DISPLAY  "SRYCD,TEN,KAISU(2) = " 
      **                                     LNK-DPCNYUIN-SRYCD(5 IDX1 2)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(5 IDX1 2)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(5 IDX1 2)
      **          DISPLAY  "SRYCD,TEN,KAISU(3) = " 
      **                                     LNK-DPCNYUIN-SRYCD(5 IDX1 3)
      **                                     ","
      **                                     LNK-DPCNYUIN-TEN(5 IDX1 3)
      **                                     ","
      **                                     LNK-DPCNYUIN-KAISU(5 IDX1 3)
      **     END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為取得
      *****************************************************************
       210-NYUINACT-GET-SEC            SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM       TO  NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key9"          TO  MCP-PATHNAME
               PERFORM   910-NYUINACT-READ-SEC
           END-IF
      *
      *    入院行為クローズ
           MOVE     "tbl_nyuinact"     TO  MCP-TABLE
           MOVE     "key9"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       210-NYUINACT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊前処理
      *****************************************************************
       210-GAIHAKU-MAE-SEC            SECTION.
      *
      *    外泊コード編集用に入院基本料加算区分と診療区分の退避
           INITIALIZE                      TNS-TENSU-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM
                                       TO  TNS-HOSPNUM
           MOVE    NSRY-SRYCD(1)       TO  TNS-SRYCD
           MOVE    LNK-DPCNYUIN-SANTEIYM
                                       TO  TNS-YUKOSTYMD(1:6)
           MOVE    "01"                TO  TNS-YUKOSTYMD(7:2)
           MOVE    TNS-YUKOSTYMD       TO  TNS-YUKOEDYMD
           PERFORM 910-TENSU-READ-SEC
           MOVE    TNS-NYUKHNKSNKBN    TO  WRK-KSNKBN
           MOVE    TNS-CHUKSNCD        TO  WRK-CHUKSNCD-XXX
           MOVE    TNS-NYUKHNKBN       TO  WRK-NYUKHNKBN-XXX
      *
      *    入院基本料加算区分置き換え
           IF  LNK-DPCNYUIN-SANTEIYM   >= "201804"
      *        療養病棟入院基本料（特別入院基本料）
               IF   (TNS-NYUKHNKSNKBN = 27 )
               AND  (TNS-CDKBN-KBNNUM = 101)
                    MOVE   901   TO   WRK-KSNKBN
               END-IF
      *        有床診療所療養病床入院基本料（特別入院基本料）
               IF   (TNS-NYUKHNKSNKBN = 27 )
               AND  (TNS-CDKBN-KBNNUM = 109)
                    MOVE   909   TO   WRK-KSNKBN
               END-IF
           END-IF
      *
           .
       210-GAIHAKU-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得
      *****************************************************************
       210-GAIHAKU-SET-SEC            SECTION.
      *
      *     DISPLAY "210-GAIHAKU-SET-SEC"
           MOVE   NACCT-DAY(IDX1)     TO    WRK-GAIHAKU-KBN(IDX1)
      *     DISPLAY "WRK-SRYKBN(IDX1) = " WRK-SRYKBN(IDX1)
      *
           EVALUATE   WRK-SRYKBN(IDX1)
              WHEN     "90"
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     1
      *            AZU-ADD START 2015.6.10
                    WHEN     3
      *            AZU-ADD END   2015.6.10
                      MOVE   "190107290"   TO  WRK-GAIHAKU(IDX1)
                    WHEN     2
                      MOVE   "190107390"   TO  WRK-GAIHAKU(IDX1)
                    WHEN     4
                    WHEN     5
                    WHEN     6
                    WHEN     7
                    WHEN    14
                    WHEN    15
                    WHEN    16
                      PERFORM   2101-GAIHAKU-TAKIKAN-SEC
                    WHEN     8
                    WHEN     9
      ***           WHEN    10
      ***           WHEN    11
      ***           WHEN    12
                    WHEN    13
                    WHEN    17
                      PERFORM   2101-GAIHAKU-GENSAN-SEC
                 END-EVALUATE
              WHEN     "92"
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     1
                      MOVE   "190107490"   TO  WRK-GAIHAKU(IDX1)
                    WHEN     2
                      MOVE   "190107590"   TO  WRK-GAIHAKU(IDX1)
                    WHEN     4
                    WHEN     5
                    WHEN     6
                    WHEN     7
                    WHEN    14
                    WHEN    15
                    WHEN    16
                      PERFORM   2101-GAIHAKU-TAKIKAN-SEC
                    WHEN     8
                    WHEN     9
      ***           WHEN    10
      ***           WHEN    11
      ***           WHEN    12
                    WHEN    13
                    WHEN    17
                      PERFORM   2101-GAIHAKU-GENSAN-SEC
                 END-EVALUATE
           END-EVALUATE
      *     DISPLAY "IDX1 = " IDX1
      *     DISPLAY "WRK-GAIHAKU(IDX1) = " WRK-GAIHAKU(IDX1)
      *
           .
       210-GAIHAKU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得
      *****************************************************************
       2101-GAIHAKU-TAKIKAN-SEC           SECTION.
      *
           IF       LNK-DPCNYUIN-SANTEIYM  >=  "201804"
                   PERFORM   2101-GAIHAKU-TAKIKAN3-SEC
           ELSE
             IF     LNK-DPCNYUIN-SANTEIYM  >=  "201604"
                   PERFORM   2101-GAIHAKU-TAKIKAN2-SEC
             ELSE
                   PERFORM   2101-GAIHAKU-TAKIKAN1-SEC
             END-IF
           END-IF
      *
           .
       2101-GAIHAKU-TAKIKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得１
      *****************************************************************
       2101-GAIHAKU-TAKIKAN1-SEC           SECTION.
      *
           EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
      *
               WHEN   099  THRU  100
                 IF   LNK-DPCNYUIN-SANTEIYM  >=  "201004"
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 END-IF
               WHEN   201  THRU  219
               WHEN   221  THRU  222
               WHEN   224
               WHEN   227  THRU  229
               WHEN   230  THRU  239
               WHEN   241  THRU  249
               WHEN   250  THRU  255
      *        (H26-ADD-ST)
               WHEN   256
               WHEN   257  THRU  259
               WHEN   260  THRU  261
               WHEN   262  THRU  265
               WHEN   266  THRU  267
      *        (H26-ADD-ED)
                 IF    WRK-NYUKHNKSNKBN(IDX1) = 221 OR 232
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108790"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     6
                      MOVE   "190153190"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     7
                      MOVE   "190153390"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 ELSE
                   IF  WRK-NYUKHNKSNKBN(IDX1) =
                           229 OR 238 OR 215 OR 216 OR 217 OR 239
                                                           OR 252
                     EVALUATE   NACCT-DAY(IDX1)
                       WHEN     4
                         MOVE   "190108790" TO   WRK-GAIHAKU(IDX1)
                       WHEN     5
                         MOVE   "190142090" TO   WRK-GAIHAKU(IDX1)
                       WHEN     6
                         MOVE   "190153190" TO   WRK-GAIHAKU(IDX1)
                     END-EVALUATE
                   ELSE
                     EVALUATE   NACCT-DAY(IDX1)
                       WHEN     4
                         MOVE   "190108790" TO   WRK-GAIHAKU(IDX1)
                       WHEN     5
                         MOVE   "190142090" TO   WRK-GAIHAKU(IDX1)
                     END-EVALUATE
                   END-IF
                 END-IF
               WHEN   013  THRU  021
               WHEN   101  THRU  109
               WHEN   147  THRU  152
               WHEN   173  THRU  190
               WHEN   196
      *        (H26-ADD-ST)
               WHEN   199
               WHEN   004  THRU  008
               WHEN   010  THRU  012
      *        (H26-ADD-ED)
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
               WHEN   075  THRU  080
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108990"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
               WHEN   085  THRU  086
               WHEN   132  THRU  133
               WHEN   153  THRU  158
                 IF    WRK-NYUKHNKSNKBN(IDX1) =
                           153 OR 154 OR 155 OR 156 OR 157 OR 158
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190109090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142290"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     7
                      MOVE   "190153290"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 ELSE
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190109090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142290"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 END-IF
               WHEN   226
               WHEN   240
                 CONTINUE
               WHEN   031
               WHEN   033
               WHEN   034
               WHEN   035
               WHEN   038
               WHEN   170
               WHEN   191
      *        (H26-ADD-ST)
               WHEN   017  THRU  020
      *        (H26-ADD-ED)
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     5
                      MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     7
                      MOVE   "190153090"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
               WHEN   022
               WHEN   023
               WHEN   024
               WHEN   025
               WHEN   026
               WHEN   029
               WHEN   136
               WHEN   168
               WHEN   169
      *        (H26-ADD-ST)
               WHEN   013  THRU  016
      *        (H26-ADD-ED)
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     5
                      MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     7
                      MOVE   "190153090"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
               WHEN   081
               WHEN   083
               WHEN   172
      *        (H26-ADD-ST)
               WHEN   032  THRU  037
      *        (H26-ADD-ED)
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     5
                      MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     7
                      MOVE   "190153090"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
               WHEN   OTHER
                 EVALUATE   NACCT-DAY(IDX1)
                    WHEN     5
                      MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
      *
           END-EVALUATE
      *
           .
       2101-GAIHAKU-TAKIKAN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得２  201604
      *****************************************************************
       2101-GAIHAKU-TAKIKAN2-SEC           SECTION.
      *
           EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
      *        特定入院料
               WHEN   201  THRU  206
               WHEN   208  THRU  210
               WHEN   212  THRU  217
               WHEN   221
               WHEN   227  THRU  229
               WHEN   232  THRU  236
               WHEN   238  THRU  239
               WHEN   241  THRU  249
               WHEN   250  THRU  254
               WHEN   257  THRU  267
      *        --- H28.4 TUIKA ---
               WHEN   268  THRU  270
      *          認知症治療病棟入院料、精神療養病棟入院料
      *          地域移行機能強化病棟入院料
                 IF  WRK-NYUKHNKSNKBN(IDX1) = 221 OR 232 OR 217 OR 268
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108790"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     6
                      MOVE   "190182990"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 ELSE
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108790"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142090"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 END-IF
      *        療養病棟入院基本料
               WHEN   004  THRU  008
               WHEN   010  THRU  012
               WHEN   152
               WHEN   173  THRU  190
               WHEN   196
               WHEN   199
      *        --- H28.4 TUIKA ---
               WHEN   048  THRU  049
               WHEN   051  THRU  054
               WHEN   057  THRU  068
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     4
                    MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     5
                    MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
      *        有床診療所療養病床入院基本料
               WHEN   153  THRU  158
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     4
                    MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     5
                    MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     6
                    MOVE   "190109090"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
      *        短期滞在手術基本料２・短期滞在手術基本料３
               WHEN   226
               WHEN   240
                 CONTINUE
               WHEN   OTHER
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     5
                    MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
           END-EVALUATE
      *
           .
       2101-GAIHAKU-TAKIKAN2-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊診療コード取得３  201804
      *****************************************************************
       2101-GAIHAKU-TAKIKAN3-SEC           SECTION.
      *
           EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
      *        特定入院料
               WHEN   200  THRU  257
               WHEN   260  THRU  263
      *          認知症治療病棟入院料、精神療養病棟入院料
      *          地域移行機能強化病棟入院料
                 IF  WRK-NYUKHNKSNKBN(IDX1) = 255 OR 254 OR 257
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108790"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     6
                      MOVE   "190182990"    TO   WRK-GAIHAKU(IDX1)
                    WHEN    14
                      MOVE   "190214390"    TO   WRK-GAIHAKU(IDX1)
                    WHEN    15
                      MOVE   "190213990"    TO   WRK-GAIHAKU(IDX1)
                    WHEN    16
                      MOVE   "190214190"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 ELSE
                   EVALUATE   NACCT-DAY(IDX1)
                    WHEN     4
                      MOVE   "190108790"    TO   WRK-GAIHAKU(IDX1)
                    WHEN     5
                      MOVE   "190142090"    TO   WRK-GAIHAKU(IDX1)
                    WHEN    14
                      MOVE   "190214390"    TO   WRK-GAIHAKU(IDX1)
                    WHEN    15
                      MOVE   "190213990"    TO   WRK-GAIHAKU(IDX1)
                   END-EVALUATE
                 END-IF
      *        療養病棟入院基本料
               WHEN    11  THRU   14
               WHEN    51
               WHEN   901
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     4
                    MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     5
                    MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    14
                    MOVE   "190214290"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    15
                    MOVE   "190213890"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
      *        有床診療所療養病床入院基本料
               WHEN    26
               WHEN    53
               WHEN   909
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     4
                    MOVE   "190108890"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     5
                    MOVE   "190142190"    TO   WRK-GAIHAKU(IDX1)
                  WHEN     6
                    MOVE   "190109090"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    14
                    MOVE   "190214290"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    15
                    MOVE   "190213890"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    16
                    MOVE   "190214090"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
      *        短期滞在手術基本料２・短期滞在手術基本料３
               WHEN   258  THRU  259
                 CONTINUE
               WHEN   OTHER
                 EVALUATE   NACCT-DAY(IDX1)
                  WHEN     5
                    MOVE   "190141590"    TO   WRK-GAIHAKU(IDX1)
                  WHEN    14
                    MOVE   "190213790"    TO   WRK-GAIHAKU(IDX1)
                 END-EVALUATE
           END-EVALUATE
      *
           .
       2101-GAIHAKU-TAKIKAN3-EXT.
           EXIT.
      *
      *****************************************************************
      *    減算コード取得
      *****************************************************************
       2101-GAIHAKU-GENSAN-SEC           SECTION.
      *
           IF       LNK-DPCNYUIN-SANTEIYM  >=  "201804"
                   PERFORM   2101-GAIHAKU-GENSAN3-SEC
           ELSE
             IF     LNK-DPCNYUIN-SANTEIYM  >=  "201604"
                   PERFORM   2101-GAIHAKU-GENSAN2-SEC
             ELSE
                   PERFORM   2101-GAIHAKU-GENSAN1-SEC
             END-IF
           END-IF
      *
           .
       2101-GAIHAKU-GENSAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    減算コード取得１
      *****************************************************************
       2101-GAIHAKU-GENSAN1-SEC           SECTION.
      *
           EVALUATE   NACCT-DAY(IDX1)
             WHEN     8
      ***    WHEN    11
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      IF   LNK-DPCNYUIN-SANTEIYM  >=  "201404"
                        IF  (WRK-NYUKHNKBN(IDX1) =   79 OR 88  )
                        OR  (WRK-NYUINKHN(IDX1)  =  "190799510")
                          MOVE  "190161570" TO   WRK-GAIHAKU(IDX1)
                        ELSE
                          MOVE  "190161470" TO   WRK-GAIHAKU(IDX1)
                        END-IF
                      ELSE
                          MOVE  "190161470" TO   WRK-GAIHAKU(IDX1)
                      END-IF
                   WHEN   "9018"
                      MOVE   "190161570"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9026"
                      MOVE   "190161870"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162070"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 11
                    EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                     WHEN   099  THRU  100
                      MOVE   "190142190"    TO   WRK-GAIHAKU2(IDX1)
                     WHEN   OTHER
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                    END-EVALUATE
                END-IF
             WHEN     9
             WHEN    13
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      IF   LNK-DPCNYUIN-SANTEIYM  >=  "201404"
                        IF  (WRK-NYUKHNKBN(IDX1) =   79 OR 88  )
                        OR  (WRK-NYUINKHN(IDX1)  =  "190799510")
                          MOVE  "190161770" TO   WRK-GAIHAKU(IDX1)
                        ELSE
                          MOVE  "190161670" TO   WRK-GAIHAKU(IDX1)
                        END-IF
                      ELSE
                          MOVE  "190161670" TO   WRK-GAIHAKU(IDX1)
                      END-IF
                   WHEN   "9018"
                      MOVE   "190161770"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9026"
                      MOVE   "190161970"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162170"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 13
                    EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                     WHEN   099  THRU  100
                      MOVE   "190142190"    TO   WRK-GAIHAKU2(IDX1)
                     WHEN   OTHER
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                    END-EVALUATE
                END-IF
           END-EVALUATE
      *
           .
       2101-GAIHAKU-GENSAN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    減算コード取得２  201604
      *****************************************************************
       2101-GAIHAKU-GENSAN2-SEC           SECTION.
      *
           EVALUATE   NACCT-DAY(IDX1)
             WHEN     8
      ***    WHEN    11
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                        WHEN     9
                        WHEN    42   THRU   44
                        WHEN    47
                        WHEN   166   THRU  167
                        WHEN   197   THRU  198
                          MOVE  "190161570" TO   WRK-GAIHAKU(IDX1)
                        WHEN   OTHER
                          MOVE  "190161470" TO   WRK-GAIHAKU(IDX1)
                      END-EVALUATE
                   WHEN   "9026"
                      MOVE   "190161870"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162070"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9090"
                      MOVE   "190198570"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 11
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                END-IF
             WHEN     9
             WHEN    13
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                        WHEN     9
                        WHEN    42   THRU   44
                        WHEN    47
                        WHEN   166   THRU  167
                        WHEN   197   THRU  198
                          MOVE  "190161770" TO   WRK-GAIHAKU(IDX1)
                        WHEN   OTHER
                          MOVE  "190161670" TO   WRK-GAIHAKU(IDX1)
                      END-EVALUATE
                   WHEN   "9026"
                      MOVE   "190161970"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162170"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9090"
                      MOVE   "190198670"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 13
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                END-IF
           END-EVALUATE
      *
           .
       2101-GAIHAKU-GENSAN2-EXT.
           EXIT.
      *
      *****************************************************************
      *    減算コード取得３  201804
      *****************************************************************
       2101-GAIHAKU-GENSAN3-SEC           SECTION.
      *
           EVALUATE   NACCT-DAY(IDX1)
             WHEN     8
      ***    WHEN    11
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                        WHEN    27
                        WHEN    40
                          MOVE  "190161570" TO   WRK-GAIHAKU(IDX1)
                        WHEN   OTHER
                          MOVE  "190161470" TO   WRK-GAIHAKU(IDX1)
                      END-EVALUATE
                   WHEN   "9026"
                      MOVE   "190161870"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162070"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9090"
                      MOVE   "190198570"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 11
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                END-IF
             WHEN     9
             WHEN    13
             WHEN    17
                EVALUATE   WRK-CHUKSNCD(IDX1)
                   WHEN   "9017"
                      EVALUATE   WRK-NYUKHNKSNKBN(IDX1)
                        WHEN    27
                        WHEN    40
                          MOVE  "190161770" TO   WRK-GAIHAKU(IDX1)
                        WHEN   OTHER
                          MOVE  "190161670" TO   WRK-GAIHAKU(IDX1)
                      END-EVALUATE
                   WHEN   "9026"
                      MOVE   "190161970"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9030"
                      MOVE   "190162170"    TO   WRK-GAIHAKU(IDX1)
                   WHEN   "9090"
                      MOVE   "190198670"    TO   WRK-GAIHAKU(IDX1)
                END-EVALUATE
                IF   NACCT-DAY(IDX1) = 13
                      MOVE   "190141590"    TO   WRK-GAIHAKU2(IDX1)
                END-IF
                IF   NACCT-DAY(IDX1) = 17
                      MOVE   "190213790"    TO   WRK-GAIHAKU2(IDX1)
                END-IF
           END-EVALUATE
      *
           .
       2101-GAIHAKU-GENSAN3-EXT.
           EXIT.
      *
      *****************************************************************
      *    老人対象患者チェック
      *****************************************************************
       210-RJN-TAISYO-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-RJN
      *
      *    入院患者の老人保険判定
           MOVE    ZERO                TO   FLG-HKNCOMBI
           INITIALIZE                       HKNCOMBI-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM TO  COMB-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID  TO   COMB-PTID
           PERFORM   VARYING   IDX   FROM  1  BY  1
                     UNTIL     (WRK-HKNCOMBI-DAY(IDX)  NOT =  ZERO) OR
                               (IDX     >   31)
               IF   WRK-HKNCOMBI-DAY(IDX)   NOT =   ZERO
                  MOVE    WRK-HKNCOMBI-DAY(IDX)
                                       TO   COMB-HKNCOMBINUM
               END-IF
           END-PERFORM
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-HKNCOMBI-SELECT-SEC
           IF      FLG-HKNCOMBI        =    ZERO
               MOVE    "tbl_hkncombi"  TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   910-HKNCOMBI-READ-SEC
           END-IF
      *    保険組合せクローズ
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    入院患者の年齢計算
           INITIALIZE                      ORCSAGECHKAREA
           MOVE    LNK-DPCNYUIN-HOSPNUM
                                       TO  AGECHK-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID
                                       TO  AGECHK-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM
                                       TO  AGECHK-SRYYMD(1:6)
           MOVE    "01"                TO  AGECHK-SRYYMD(7:2)
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"        USING
                                           ORCSAGECHKAREA
                                           SPA-AREA
           IF    ( AGECHK-RC           =   ZERO )
               CONTINUE
           ELSE
               INITIALIZE  ORCSAGECHKAREA
           END-IF
      *
      *    老人対象患者判定
           IF    ((FLG-HKNCOMBI        =   ZERO)    AND
                  (COMB-KOH1HKNNUM     =   "027"))   OR
                 ( AGECHK-NENREI      >=    75)      OR
                 ((AGECHK-NENREI      >=    70)     AND
                  (PTINF-BIRTHDAY     <=   "19320930"))
               MOVE    1               TO  FLG-RJN
           END-IF
      *
           .
       210-RJN-TAISYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算処理
      *****************************************************************
       210-TENSU-KEISAN-SEC            SECTION.
      *
           INITIALIZE                      TNS-TENSU-REC
           IF     (IDX2                   =     1  )
           AND    (WRK-GAIHAKU(IDX1)     NOT =   SPACE)
               MOVE    SPACE             TO  WRK-GAIHAKU-SRYCD
               IF    LNK-DPCNYUIN-SANTEIYM   <=  "201203"
                  PERFORM    2101-GAIHAKU-NYUINKHN-SET-SEC
               END-IF
               IF    WRK-GAIHAKU-SRYCD   NOT =  SPACE
                  MOVE    WRK-GAIHAKU-SRYCD
                                         TO  TNS-SRYCD
               ELSE
                  MOVE    WRK-SO-SRYCD(IDX1 IDX2)
                                         TO  TNS-SRYCD
               END-IF
           ELSE
                  MOVE    WRK-SO-SRYCD(IDX1 IDX2)
                                         TO  TNS-SRYCD
           END-IF
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  TNS-HOSPNUM
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  TNS-YUKOSTYMD(1:6)
           MOVE    "01"                  TO  TNS-YUKOSTYMD(7:2)
           MOVE    TNS-YUKOSTYMD         TO  TNS-YUKOEDYMD
           MOVE    TNS-SRYCD             TO  WRK-TENSU-CD
           PERFORM 910-TENSUWRK-CHK-SEC
           IF      FLG-TENSUWRK   =    ZERO
               PERFORM 910-TENSU-READ-SEC
               PERFORM 910-TTNS-HEN-SEC
           END-IF
      *
      *    点数算定
           EVALUATE    TNS-TENSIKIBETU
      *        点数（プラス）
               WHEN    3
                   ADD   TNS-TEN     TO  WRK-SO-TEN(IDX1)
      *        ％加算
               WHEN    5
                   COMPUTE    WRK-SO-TEN(IDX1)  =
                              WRK-SO-TEN(IDX1)  +
                            ((WRK-SO-TEN(IDX1)  *
                              (TNS-TEN   /  100))  + 0.5)
      *        ％減算
               WHEN    6
      *            AZU-MOD START 2015.6.10
                   IF (WRK-SENTEI-GAIGAKU(IDX1)  =   1)  AND
                      (TNS-SRYCD                 =  "190107290")
                      MOVE    100     TO    TNS-TEN
                   END-IF
                   COMPUTE    WRK-SO-TEN(IDX1)  =
                            ( WRK-SO-TEN(IDX1)  -
                             (WRK-SO-TEN(IDX1)  *
                             (TNS-TEN   /  100)))        +  0.5
      *        点数（マイナス）
               WHEN    8
                   COMPUTE  WRK-SO-TEN(IDX1)  =
                            WRK-SO-TEN(IDX1)  -  TNS-TEN
      *        WHEN  OTHER
      *            ADD   TNS-TEN     TO  WRK-SO-TEN(IDX1)
           END-EVALUATE
      *
      *    診療コード計
           MOVE    TNS-SRYCD          TO  WRK-SRYCD-X
           COMPUTE WRK-SO-SRYCDTOTAL(IDX1)  =
                   WRK-SO-SRYCDTOTAL(IDX1)  +   WRK-SRYCD-9
           ADD      1          TO  WRK-SO-MEISAISU(IDX1)
      *
           .
       210-TENSU-KEISAN-EXT.
           EXIT.
      *
      **************************************************************
      *    外泊時の入院基本料取得
      **************************************************************
       2101-GAIHAKU-NYUINKHN-SET-SEC           SECTION.
      *
           MOVE    SPACE    TO   WRK-GAIHAKU-SRYCD
      *
           EVALUATE  WRK-SO-SRYCD(IDX1 IDX2)
               WHEN  "190078210"
                     MOVE  "190077410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078310"
                     MOVE  "190077510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078410"
                     MOVE  "190077610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078510"
                     MOVE  "190077710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078610"
                     MOVE  "190077810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078710"
                     MOVE  "190077910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078810"
                     MOVE  "190078010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078910"
                     MOVE  "190078110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190082410"
                     MOVE  "190081710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082510"
                     MOVE  "190081810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082610"
                     MOVE  "190081910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082710"
                     MOVE  "190082010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082810"
                     MOVE  "190082110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082910"
                     MOVE  "190082210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190083010"
                     MOVE  "190082310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190084310"
                     MOVE  "190083610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084410"
                     MOVE  "190083710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084510"
                     MOVE  "190083810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084610"
                     MOVE  "190083910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084710"
                     MOVE  "190084010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084810"
                     MOVE  "190084110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084910"
                     MOVE  "190084210"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190087410"
                     MOVE  "190085910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087510"
                     MOVE  "190086010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087610"
                     MOVE  "190086110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087710"
                     MOVE  "190086210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087810"
                     MOVE  "190086310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087910"
                     MOVE  "190086410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088010"
                     MOVE  "190086510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088110"
                     MOVE  "190086610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088210"
                     MOVE  "190086710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088310"
                     MOVE  "190086810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088410"
                     MOVE  "190086910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088510"
                     MOVE  "190087010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088610"
                     MOVE  "190087110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088710"
                     MOVE  "190087210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088810"
                     MOVE  "190087310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190094710"
                     MOVE  "190093710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094810"
                     MOVE  "190093810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094910"
                     MOVE  "190093910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095010"
                     MOVE  "190094010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095110"
                     MOVE  "190094110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190797410"
                     MOVE  "190796610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797510"
                     MOVE  "190796710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797610"
                     MOVE  "190796810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797710"
                     MOVE  "190796910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797810"
                     MOVE  "190797010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797910"
                     MOVE  "190797110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798010"
                     MOVE  "190797210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798110"
                     MOVE  "190797310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190803510"
                     MOVE  "190802810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803610"
                     MOVE  "190802910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803710"
                     MOVE  "190803010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803810"
                     MOVE  "190803110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803910"
                     MOVE  "190803210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804010"
                     MOVE  "190803310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804110"
                     MOVE  "190803410"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190091210"
                     MOVE  "190090210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190091310"
                     MOVE  "190090310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190109670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190808870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190117070"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190813270"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190117670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190813870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *        診療所老人医療管理料
               WHEN  "190774210"
                     MOVE  "190774110"      TO   WRK-GAIHAKU-SRYCD
      *        老人性認知症疾患治療病棟入院料１
               WHEN  "190740010"
                     MOVE  "190739910"      TO   WRK-GAIHAKU-SRYCD
      *        老人性認知症疾患治療病棟入院料２
               WHEN  "190813510"
                     MOVE  "190813410"      TO   WRK-GAIHAKU-SRYCD
           END-EVALUATE
      *
           IF   (LNK-DPCNYUIN-SANTEIYM  >= "200604"   )
           AND  (WRK-GAIHAKU-SRYCD  = "190774110" OR
                                      "190739910" OR
                                      "190813410")
               MOVE    SPACE    TO    WRK-GAIHAKU-SRYCD
           END-IF
      *
           IF    WRK-GAIHAKU-SRYCD   NOT =   SPACE
               MOVE   WRK-GAIHAKU-SRYCD   TO   WRK-SO-SRYCD(IDX1 IDX2)
           END-IF
      *
           .
       2101-GAIHAKU-NYUINKHN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    食事情報の編集（平成１８年４月以降　食事療養費食数ベース）
      *                  （平成２８年３月まで）
      *****************************************************************
       2103-SHOKUJI-HENSHU3-SEC        SECTION.
      *
      *食事情報の取得（朝食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key30"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key30"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX1)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX1)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                       END-EVALUATE
      *                食堂加算
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key30"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（昼食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key31"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key31"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX2   =    IDX1   +   31
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX2)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX2)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX2)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key31"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（夕食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key32"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key32"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX3   =    IDX1   +   62
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX3)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX3)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                            TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX3)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key32"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *低所得情報の取得
           INITIALIZE                          TSYRRK-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  TSYRRK-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  TSYRRK-PTID
           MOVE    "tbl_tsyrrk"            TO  MCP-TABLE
           MOVE    "key3"                  TO  MCP-PATHNAME
           PERFORM 910-TSYRRK-SELECT-SEC
           IF      FLG-TSYRRK              =   ZERO
               MOVE    "tbl_tsyrrk"        TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 910-TSYRRK-READ-SEC
               PERFORM  UNTIL  
                  ( FLG-TSYRRK          =   1                ) OR
                 (( TSYRRK-NINSTYMD(1:6) <= LNK-DPCNYUIN-SANTEIYM AND
                    LNK-DPCNYUIN-SANTEIYM <= TSYRRK-NINEDYMD(1:6) ))
      *
                   MOVE    "tbl_tsyrrk"     TO  MCP-TABLE
                   MOVE    "key3"           TO  MCP-PATHNAME
                   PERFORM 910-TSYRRK-READ-SEC
      *
               END-PERFORM
           END-IF
           IF      FLG-TSYRRK              =   ZERO
              IF  (LNK-DPCNYUIN-SANTEIYM   =  TSYRRK-NINSTYMD(1:6))
              AND (TSYRRK-NINSTYMD(7:2)      NOT =  "01")
                CONTINUE
              ELSE
                PERFORM   VARYING   IDX1   FROM   1  BY  1
                          UNTIL     IDX1   >    93
                    IF    WRK-SKJ4-RYOYO(IDX1)  NOT =  SPACE
                        MOVE   "197000910"
                                        TO  WRK-SKJFTN2-SRYCD(IDX1)
                    END-IF
                END-PERFORM
              END-IF
           END-IF
      *
           MOVE     "tbl_tsyrrk"        TO  MCP-TABLE
           MOVE     "key3"              TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *９０日越え（低所得情報）
           IF  (TSYRRK-SKJGNSTYMD(1:6)  <= LNK-DPCNYUIN-SANTEIYM) AND
               (TSYRRK-SKJGNSTYMD       NOT = SPACE)
             IF (LNK-DPCNYUIN-SANTEIYM  = TSYRRK-SKJGNSTYMD(1:6)) AND
                (TSYRRK-SKJGNSTYMD(7:2)   NOT = "01")
               CONTINUE
             ELSE
               IF  TSYRRK-SKJGNSTYMD(1:6)  <  LNK-DPCNYUIN-SANTEIYM
                   MOVE   1             TO   TSY90-IDX
               ELSE
                   MOVE   TSYRRK-SKJGNSTYMD(7:2)   TO  TSY90-IDX
               END-IF
               PERFORM   VARYING   IDX1   FROM   TSY90-IDX  BY  1
                          UNTIL     IDX1   >    31
                    IF    WRK-SKJ4-RYOYO(IDX1)  NOT =  SPACE
                        MOVE   "197001010"
                                        TO  WRK-SKJFTN2-SRYCD(IDX1)
                    END-IF
                    COMPUTE   IDX-TSY90  =  IDX1  +  31
                    IF    WRK-SKJ4-RYOYO(IDX-TSY90)  NOT =  SPACE
                        MOVE   "197001010"
                                        TO  WRK-SKJFTN2-SRYCD(IDX-TSY90)
                    END-IF
                    COMPUTE   IDX-TSY90  =  IDX1  +  62
                    IF    WRK-SKJ4-RYOYO(IDX-TSY90)  NOT =  SPACE
                        MOVE   "197001010"
                                        TO  WRK-SKJFTN2-SRYCD(IDX-TSY90)
                    END-IF
               END-PERFORM
             END-IF
           END-IF
      *
      *低年金情報の取得
           INITIALIZE                          TNKRRK-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  TNKRRK-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  TNKRRK-PTID
           MOVE    "tbl_tnkrrk"            TO  MCP-TABLE
           MOVE    "key3"                  TO  MCP-PATHNAME
           PERFORM 910-TNKRRK-SELECT-SEC
           IF      FLG-TNKRRK              =   ZERO
               MOVE    "tbl_tnkrrk"        TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 910-TNKRRK-READ-SEC
               PERFORM  UNTIL  
                  ( FLG-TNKRRK          =   1                ) OR
                 (( TNKRRK-STYMD(1:6) <= LNK-DPCNYUIN-SANTEIYM AND
                    LNK-DPCNYUIN-SANTEIYM <= TNKRRK-EDYMD(1:6) ))
      *
                   MOVE    "tbl_tnkrrk"       TO  MCP-TABLE
                   MOVE    "key3"             TO  MCP-PATHNAME
                   PERFORM 910-TNKRRK-READ-SEC
      *
               END-PERFORM
           END-IF
           IF      FLG-TNKRRK              =   ZERO
              IF  (LNK-DPCNYUIN-SANTEIYM   =  TNKRRK-STYMD(1:6))
              AND (TNKRRK-STYMD(7:2)     NOT =  "01")
                CONTINUE
              ELSE
                PERFORM   VARYING   IDX1   FROM   1  BY  1
                          UNTIL     IDX1   >    93
                    IF    WRK-SKJ4-RYOYO(IDX1)  NOT =  SPACE
                        MOVE   "197001110"
                                        TO  WRK-SKJFTN2-SRYCD(IDX1)
                    END-IF
                END-PERFORM
              END-IF
           END-IF
      *
           MOVE     "tbl_tnkrrk"        TO  MCP-TABLE
           MOVE     "key3"              TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *    入院時生活療養費の情報取得
           INITIALIZE                          ORCSNYULIFE-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  LNK-NYULIFE-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  LNK-NYULIFE-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  LNK-NYULIFE-SANTEIYM
           CALL    "ORCSNYULIFE"     USING  ORCSNYULIFE-AREA
                                            SPA-AREA
           IF      LNK-NYULIFE-RC          NOT =  ZERO
               DISPLAY  "LNK-NYULIFE-RC = " LNK-NYULIFE-RC
           END-IF
      *
      *    食事ワーク７の編集（同一剤まとめ用）
           PERFORM      VARYING    IDX1   FROM   1  BY  1
                        UNTIL      IDX1   >   31
      *        食事療養費（朝）
               IF    WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                   MOVE  WRK-SKJ4-RYOYO(IDX1)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJ-SRYCD(IDX1)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-RYOYO-SU(IDX1)
               END-IF
      *        特別食加算（朝）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX1)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（朝）
               IF    WRK-SKJFTN2-SRYCD(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事療養費（昼）
               MOVE      ZERO          TO  IDX2
               COMPUTE   IDX2     =    IDX1    +   31
               IF    WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
                                       TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                   MOVE  WRK-SKJ4-RYOYO(IDX2)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJ-SRYCD(IDX1)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-RYOYO-SU(IDX1)
               END-IF
      *        特別食加算（昼）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX2)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（昼）
               IF    WRK-SKJFTN2-SRYCD(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX2)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事療養費（夕）
               MOVE      ZERO          TO  IDX3
               COMPUTE   IDX3     =    IDX1    +   62
               IF    WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
                                       TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                   MOVE  WRK-SKJ4-RYOYO(IDX3)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJ-SRYCD(IDX1)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-RYOYO-SU(IDX1)
               END-IF
      *        特別食加算（夕）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX3)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（夕）
               IF    WRK-SKJFTN2-SRYCD(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX3)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-SKJFTN-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事回数
      **         IF    (WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE)
      **             MOVE      1         TO   WRK-SKJ7-KAISU(IDX1)
      **         END-IF
      *        食堂加算
               IF    WRK-SKJ6-SHOKUDOU(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ6-SHOKUDOU(IDX1)
                                       TO  WRK-SKJ7-SHOKUDOU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE-SKJ-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  "197001670"
                                       TO  WRK-SKJ7-SHOKUDOU(IDX1)
                   END-IF
               END-IF
           END-PERFORM
      *
      *    食事の診療コード計
           PERFORM    VARYING   IDX1    FROM  1  BY  1
                      UNTIL     IDX1    >   31
               IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-RYOYO(IDX1)       TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-SHOKUDOU(IDX1)    TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
      **         IF   WRK-SKJ7-TOKU-SHOKU(IDX1)  NOT =  SPACE
      **             MOVE    WRK-SKJ7-TOKU-SHOKU(IDX1)  TO WRK-SRYCD-X
      **             COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
      **                     WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
      **         END-IF
               IF   WRK-SKJ7-SKJFTN(IDX1)      NOT =  SPACE
                   MOVE    WRK-SKJ7-SKJFTN(IDX1)  TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               ADD   WRK-SKJ7-RYOYO-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
      **         ADD   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      **                               TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               EVALUATE    WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
                   WHEN    1
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
                   WHEN    2
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
                   WHEN    3
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
               END-EVALUATE
               ADD   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
           END-PERFORM
      *
      *     DISPLAY "WRK-SKJ7  MATOME BEFORE"
      *     PERFORM      VARYING    IDX1   FROM   1  BY  1
      *                  UNTIL      IDX1   >   31
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
      *          DISPLAY "WRK-SKJ7-SRYCDTOTAL =(IDX1) = "
      *                   WRK-SKJ7-SRYCDTOTAL (IDX1)
      *     END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの食事セット
           MOVE       ZERO    TO   IDX2
           MOVE       ZERO    TO   IDX3
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
      *          DISPLAY "WRK-SKJ7  MATOME AFTER"
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
              IF    WRK-SKJ7-RYOYO(IDX1)   NOT =  SPACE
                IF (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001310")  AND
                   (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001710")
                    MOVE   IDX1     TO    IDX2
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(3 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                    END-IF
                    MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
                      WHEN  "197000110"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   640     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1280     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1920     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
                      WHEN  "197000710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   506     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1012     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1518     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時生活療養（１）食事療養
                      WHEN  "197001310"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   554     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1108     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1662     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時生活療養（２）食事療養
                      WHEN  "197001710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   420     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE   840     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1260     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                        MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               食事療養標準負担額（一般）
                            WHEN   "197000810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日以下）
                            WHEN   "197000910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日超）
                            WHEN   "197001010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低１）
                            WHEN   "197001110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養（１）食事療養標準負担額（一般）
                            WHEN   "197002010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養（２）食事療養標準負担額（一般）
                            WHEN   "197002110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  840  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE 1260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低２）
                            WHEN   "197002210"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低１）
                            WHEN   "197002310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福以外））
                            WHEN   "197002410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福））
                            WHEN   "197002510"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（一般））
                            WHEN   "197002710"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日以下））
                            WHEN   "197002810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日超））
                            WHEN   "197002910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低１））
                            WHEN   "197003010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(3 IDX2)
                ELSE
      *             入院時生活療養の食事療養は添字４の領域に返却
                    MOVE  IDX1      TO    IDX3
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(4 IDX3)
                    MOVE   ZERO     TO    IDX5
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
      **                  IF     IDX5    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                    END-IF
                    MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
                      WHEN  "197000110"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   640     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1280     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1920     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                      WHEN  "197000710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   506     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1012     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1518     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
      *               入院時生活療養（１）食事療養
                      WHEN  "197001310"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   554     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1108     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1662     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
      *               入院時生活療養（２）食事療養
                      WHEN  "197001710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   420     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE   840     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1260     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                       MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               食事療養標準負担額（一般）
                            WHEN   "197000810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日以下）
                            WHEN   "197000910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日超）
                            WHEN   "197001010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               食事療養標準負担額（低１）
                            WHEN   "197001110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養（１）食事療養標準負担額（一般）
                            WHEN   "197002010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養（２）食事療養標準負担額（一般）
                            WHEN   "197002110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  840  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低２）
                            WHEN   "197002210"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低１）
                            WHEN   "197002310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福以外））
                            WHEN   "197002410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福））
                            WHEN   "197002510"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（一般））
                            WHEN   "197002710"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日以下））
                            WHEN   "197002810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日超））
                            WHEN   "197002910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低１））
                            WHEN   "197003010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    MOVE  IDX5  TO  LNK-DPCNYUIN-MEISAISU(4 IDX3)
                END-IF
              END-IF
           END-PERFORM
      *
           .
       2103-SHOKUJI-HENSHU3-EXT.
           EXIT.
      *
      *****************************************************************
      *    食事情報の編集（平成２８年４月以降）
      *                  （平成２９年９月まで）
      *                  （食事療養費の流動食対応）
      *                  （食事負担の難病等、精神１年超の据え置き対応）
      *****************************************************************
       2103-SHOKUJI-HENSHU4-SEC        SECTION.
      *
      *食事情報の取得（朝食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key30"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key30"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX1)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX1)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX1)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                       END-EVALUATE
      *                食堂加算
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key30"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（昼食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key31"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key31"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX2   =    IDX1   +   31
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX2)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX2)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX2)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX2)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key31"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（夕食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key32"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key32"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX3   =    IDX1   +   62
                   IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX3)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX3)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                            TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX3)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX3)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key32"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *−−−−サブルーチンでの患者所得情報の取得ここから−−−−−
           INITIALIZE                          WRK-SYOTOKU-SKJKBN-AREA
           INITIALIZE                          ORCSSYOTOKUAREA
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  LNK-SYOTOKU-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  LNK-SYOTOKU-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  LNK-SYOTOKU-SRYYM
           MOVE    "1"                     TO  LNK-SYOTOKU-SKJCHKFLG
           CALL    "ORCSSYOTOKU"    USING      ORCSSYOTOKUAREA
                                               SPA-AREA
           IF    LNK-SYOTOKU-RC      =         ZERO
                PERFORM    VARYING   IDX1   FROM   1   BY  1
                  UNTIL   (IDX1      >     31)
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX1)
                      COMPUTE    IDX2   =   IDX1   +   31
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX2)
                      COMPUTE    IDX2   =   IDX1   +   62
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX2)
                END-PERFORM
           ELSE
                DISPLAY "ORCSSYTOKU RC = " LNK-SYOTOKU-RC
           END-IF
      *−−−−サブルーチンでの患者所得情報の取得ここまで−−−−−
      *
      *所得情報のセット
           PERFORM   VARYING   IDX1   FROM   1  BY  1
                     UNTIL     IDX1   >    93
               IF    WRK-SKJ4-RYOYO(IDX1)  NOT =  SPACE
                   EVALUATE    WRK-SYOTOKU-SKJKBN (IDX1)
      *                低所得２
                       WHEN    "2"
                           MOVE   "197000910"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
      *                低所得２（９０日越え）
                       WHEN    "3"
                           MOVE   "197001010"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
      *                低所得１
                       WHEN    "1"
                       WHEN    "4"
                           MOVE   "197001110"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                   END-EVALUATE
               END-IF
           END-PERFORM
      *
      *
      *
      *    入院時生活療養費の情報取得
           INITIALIZE                        ORCSNYULIFE2-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  LNK-NYULIFE2-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  LNK-NYULIFE2-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  LNK-NYULIFE2-SANTEIYM
           CALL    "ORCSNYULIFE2"     USING  ORCSNYULIFE2-AREA
                                             SPA-AREA
           IF      LNK-NYULIFE2-RC          NOT =  ZERO
               DISPLAY  "LNK-NYULIFE2-RC = " LNK-NYULIFE2-RC
           END-IF
      *
      *    食事負担据え置き対象取得サブ
           INITIALIZE                          ORCSSKJKEEP-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  LNK-SKJKEEP-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  LNK-SKJKEEP-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  LNK-SKJKEEP-SANTEIYM
           CALL    "ORCSSKJKEEP"    USING      ORCSSKJKEEP-AREA
                                               SPA-AREA
      *
      *    食事ワーク７の編集（同一剤まとめ用）
           PERFORM      VARYING    IDX1   FROM   1  BY  1
                        UNTIL      IDX1   >   31
      *        食事療養費（朝）
               IF   WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  =   SPACE
                     MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                     IF   WRK-SKJ4-RYOYO(IDX1)   =   CONS-SKJ-RYOYO-1-1
                                                 OR  CONS-SKJ-RYOYO-2-1
                         MOVE  WRK-SKJ4-RYOYO(IDX1)
                                         TO  WRK-SKJ7-RYOYO(IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                     END-IF
                     IF   WRK-SKJ4-RYOYO(IDX1)   =   CONS-SKJ-RYOYO-1-2
                                                 OR  CONS-SKJ-RYOYO-2-2
                         MOVE  WRK-SKJ4-RYOYO(IDX1)
                                         TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                          ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                     END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
                                       TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)
                                       TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（朝）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX1)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（朝）
               IF    WRK-SKJFTN2-SRYCD(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                       MOVE   CONS-NANBYO-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                       MOVE   CONS-SEISIN-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 1)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事療養費（昼）
               MOVE      ZERO          TO  IDX2
               COMPUTE   IDX2     =    IDX1    +   31
               IF    WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  =   SPACE
                     MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
                                         TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                     IF   WRK-SKJ4-RYOYO(IDX2)   =   CONS-SKJ-RYOYO-1-1
                                                 OR  CONS-SKJ-RYOYO-2-1
                         MOVE  WRK-SKJ4-RYOYO(IDX2)
                                         TO  WRK-SKJ7-RYOYO(IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                     END-IF
                     IF   WRK-SKJ4-RYOYO(IDX2)   =   CONS-SKJ-RYOYO-1-2
                                                 OR  CONS-SKJ-RYOYO-2-2
                         MOVE  WRK-SKJ4-RYOYO(IDX2)
                                         TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                     END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
                                         TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)
                                       TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（昼）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX2)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（昼）
               IF    WRK-SKJFTN2-SRYCD(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX2)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                       MOVE   CONS-NANBYO-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                       MOVE   CONS-SEISIN-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 2)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事療養費（夕）
               MOVE      ZERO          TO  IDX3
               COMPUTE   IDX3     =    IDX1    +   62
               IF    WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  =   SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
                                         TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                      IF   WRK-SKJ4-RYOYO(IDX3)   =   CONS-SKJ-RYOYO-1-1
                                                  OR  CONS-SKJ-RYOYO-2-1
                          MOVE  WRK-SKJ4-RYOYO(IDX3)
                                          TO  WRK-SKJ7-RYOYO(IDX1)
                          ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                      END-IF
                      IF   WRK-SKJ4-RYOYO(IDX3)   =   CONS-SKJ-RYOYO-1-2
                                                  OR  CONS-SKJ-RYOYO-2-2
                          MOVE  WRK-SKJ4-RYOYO(IDX3)
                                          TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                          ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                      END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
                                         TO  WRK-SKJ7-HKNCOMBI-DAY(IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)
                                       TO  WRK-SKJ7-RYOYO(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)
                                       TO  WRK-SKJ7-RYOYO-RYU(IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（夕）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX3)
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                       MOVE  "197001570"
                                       TO  WRK-SKJ7-TOKU-SHOKU(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
               END-IF
      *        食事負担（夕）
               IF    WRK-SKJFTN2-SRYCD(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX3)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                       MOVE   CONS-NANBYO-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                       MOVE   CONS-SEISIN-SKJFTN
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 3)
                                       TO  WRK-SKJ7-SKJFTN(IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(IDX1)
               END-IF
      *        食事回数
      **         IF    (WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE)
      **             MOVE      1         TO   WRK-SKJ7-KAISU(IDX1)
      **         END-IF
      *        食堂加算
               IF    WRK-SKJ6-SHOKUDOU(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ6-SHOKUDOU(IDX1)
                                       TO  WRK-SKJ7-SHOKUDOU(IDX1)
      *            入院時生活療養費の置換え
                   IF  (LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) = SPACE)
                         CONTINUE
                   ELSE
                       MOVE  "197001670"
                                       TO  WRK-SKJ7-SHOKUDOU(IDX1)
                   END-IF
               END-IF
           END-PERFORM
      *
      *    食事の診療コード計
           PERFORM    VARYING   IDX1    FROM  1  BY  1
                      UNTIL     IDX1    >   31
               IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-RYOYO(IDX1)       TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-RYOYO-RYU(IDX1)   TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-SHOKUDOU(IDX1)    TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
      **         IF   WRK-SKJ7-TOKU-SHOKU(IDX1)  NOT =  SPACE
      **             MOVE    WRK-SKJ7-TOKU-SHOKU(IDX1)  TO WRK-SRYCD-X
      **             COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
      **                     WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
      **         END-IF
               IF   WRK-SKJ7-SKJFTN(IDX1)      NOT =  SPACE
                   MOVE    WRK-SKJ7-SKJFTN(IDX1)  TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               ADD   WRK-SKJ7-RYOYO-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               ADD   WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
      **         ADD   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      **                               TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               EVALUATE    WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
                   WHEN    1
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
                   WHEN    2
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
                   WHEN    3
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
               END-EVALUATE
               ADD   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
           END-PERFORM
      *
      *     DISPLAY "WRK-SKJ7  MATOME BEFORE"
      *     PERFORM      VARYING    IDX1   FROM   1  BY  1
      *                  UNTIL      IDX1   >   31
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
      *          DISPLAY "WRK-SKJ7-SRYCDTOTAL =(IDX1) = "
      *                   WRK-SKJ7-SRYCDTOTAL (IDX1)
      *     END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの食事セット
           MOVE       ZERO    TO   IDX2
           MOVE       ZERO    TO   IDX3
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
      *          DISPLAY "WRK-SKJ7  MATOME AFTER"
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
              IF   (WRK-SKJ7-RYOYO(IDX1)       NOT =  SPACE)  OR
                   (WRK-SKJ7-RYOYO-RYU(IDX1)   NOT =  SPACE)
                IF (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001310")  AND
                   (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001710")  AND
                   (WRK-SKJ7-RYOYO-RYU(IDX1)   NOT = "197003510")
                    MOVE    IDX1     TO    IDX2
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(3 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    END-IF
                    MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
      *               入院時食事療養（１）
                      WHEN  "197000110"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   640     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1280     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1920     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時食事療養（２）
                      WHEN  "197000710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   506     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1012     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1518     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
      **                  IF     IDX4   =   1
                              MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO-RYU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE      WRK-SKJ7-RYOYO-RYU-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    END-IF
                    EVALUATE  WRK-SKJ7-RYOYO-RYU(IDX1)
      *               入院時食事療養（１）（流動食）
                      WHEN  "197003110"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   575     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1150     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1725     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時食事療養（２）（流動食）
                      WHEN  "197003210"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   455     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE   910     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1365     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               食事療養標準負担額（一般）
                            WHEN   "197000810"
                              IF  (LNK-DPCNYUIN-SANTEIYM
                                                        >= "201604") AND
                                  (LNK-DPCNYUIN-SANTEIYM
                                                        <= "201803")
                                 EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     WHEN   1
                                       MOVE  360  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   2
                                       MOVE  720  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   3
                                       MOVE 1080  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                 END-EVALUATE
                              END-IF
                              IF  (LNK-DPCNYUIN-SANTEIYM
                                                        >= "201804")
                                 EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     WHEN   1
                                       MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   2
                                       MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   3
                                       MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                 END-EVALUATE
                              END-IF
      *               食事療養標準負担額（指定難病・小児慢性特定疾病患者）（一般）
                            WHEN   "197003310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（精神１年超）（一般）
                            WHEN   "197003410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日以下）
                            WHEN   "197000910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日超）
                            WHEN   "197001010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低１）
                            WHEN   "197001110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(3 IDX2)
                ELSE
      *             入院時生活療養の食事療養は添字４の領域に返却
                    MOVE   IDX1       TO    IDX3
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(4 IDX3)
                    MOVE   ZERO     TO    IDX5
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
      **                  IF     IDX5    =   1
                            MOVE   "97"   TO
                            LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                    END-IF
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
      *               入院時生活療養（１）食事療養
                      WHEN  "197001310"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   554     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1108     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1662     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
      *               入院時生活療養（２）食事療養
                      WHEN  "197001710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   420     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE   840     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1260     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
      **                  IF     IDX5    =   1
                            MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO-RYU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE      WRK-SKJ7-RYOYO-RYU-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                    END-IF
                    EVALUATE  WRK-SKJ7-RYOYO-RYU(IDX1)
      *               入院時生活療養（１）食事療養（流動食）
                      WHEN  "197003510"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   500     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1000     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1500     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                       MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               生活療養（１）食事療養標準負担額（一般）
                            WHEN   "197002010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養（２）食事療養標準負担額（一般）
                            WHEN   "197002110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  840  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低２）
                            WHEN   "197002210"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低１）
                            WHEN   "197002310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福以外））
                            WHEN   "197002410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福））
                            WHEN   "197002510"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（一般））
                            WHEN   "197002710"
                              IF   LNK-DPCNYUIN-SANTEIYM
                                                        >= "201604"
                                EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  360  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  720  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1080  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                END-EVALUATE
                              END-IF
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（一般）
                            WHEN   "197003610"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（精神１年超・医療区分２・３）（一般）
                            WHEN   "197003710"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日以下））
                            WHEN   "197002810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日超））
                            WHEN   "197002910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低１））
                            WHEN   "197003010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    MOVE  IDX5  TO  LNK-DPCNYUIN-MEISAISU(4 IDX3)
                END-IF
              END-IF
           END-PERFORM
      *
           .
       2103-SHOKUJI-HENSHU4-EXT.
           EXIT.
      *
      *****************************************************************
      *    食事情報の編集（平成２９年１０月以降）
      *                  （境界層対応）
      *                  （生活療養負担コード分割対応）
      *****************************************************************
       2103-SHOKUJI-HENSHU5-SEC        SECTION.
      **     DISPLAY "2103-SHOKUJI-HENSHU5-SEC"
      **     DISPLAY "LNK-DPCNYUIN-SET-HKNCOMBI(1) = "
      **              LNK-DPCNYUIN-SET-HKNCOMBI(1)
      **     DISPLAY "LNK-DPCNYUIN-SET-HKNCOMBI(2) = "
      **              LNK-DPCNYUIN-SET-HKNCOMBI(2)
      **     DISPLAY "LNK-DPCNYUIN-SET-HKNCOMBI(3) = "
      **              LNK-DPCNYUIN-SET-HKNCOMBI(3)
      *
      *食事の保険組合せがセットされている日は入院扱いとする
           PERFORM   VARYING   IDX1   FROM  1   BY  1
                     UNTIL     IDX1   >    31
                IF   (WRK-SKJ-HKNCOMBI-ASA(IDX1) NOT = ZERO) OR
                     (WRK-SKJ-HKNCOMBI-HIRU(IDX1) NOT = ZERO) OR
                     (WRK-SKJ-HKNCOMBI-YORU(IDX1) NOT = ZERO)
                     MOVE   "XXXXXXXXX"   TO  WRK-NYUINKHN(IDX1)
                END-IF
           END-PERFORM
      *
      *食事情報の取得（朝食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key30"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key30"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
      *
                   MOVE    NACCT-DAY(IDX1) TO  WRK-SKJ-ASA-ARI(IDX1)
      *
                   IF    (WRK-SKJ-HKNCOMBI-ASA(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-SKJ-HKNCOMBI-ASA(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX1)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX1)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX1)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX1)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX1)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX1)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                               END-IF
                       END-EVALUATE
      *                食堂加算
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key30"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（昼食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key31"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key31"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX2   =    IDX1   +   31
      *
                   MOVE    NACCT-DAY(IDX1) TO  WRK-SKJ-HIRU-ARI(IDX1)
      *
                   IF    (WRK-SKJ-HKNCOMBI-HIRU(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-SKJ-HKNCOMBI-HIRU(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX2)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX2)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX2)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX2)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX2)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX2)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX2)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX2)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key31"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *食事情報の取得（夕食）（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  NACCT-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  NACCT-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  NACCT-SRYYM
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key32"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key32"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   VARYING   IDX1   FROM  1   BY  1
                         UNTIL     IDX1   >    31
                   COMPUTE   IDX3   =    IDX1   +   62
                   IF    (WRK-SKJ-HKNCOMBI-YORU(IDX1) NOT = ZERO)  AND
                         (NACCT-DAY(IDX1)    NOT =  ZERO)     AND
                        ((WRK-NYUINKHN(IDX1) NOT =  SPACE)    OR
                         (LNK-NYUINDAY-KBN(IDX1) =  "1"  ))   AND
                        ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                         (WRK-GAIHAKU-KBN(IDX1)  >= 4))
                       MOVE   WRK-SKJ-HKNCOMBI-YORU(IDX1)
                                       TO  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ5-HKNCOMBI-DAY(IDX3)
      *                                     WRK-SKJ6-HKNCOMBI-DAY(IDX3)
                                        WRK-SKJFTN2-HKNCOMBI-DAY(IDX3)
                       EVALUATE   NACCT-DAY(IDX1)
                           WHEN   1
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                            TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                           WHEN   2
                               MOVE   WRK-SYS5000-SHOKUCD(1 IDX1)
                                              TO  WRK-SKJ4-RYOYO(IDX3)
      *                        特別食加算は入院時食事療養（１）の場合
      *                        のみセット
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1)  =
                                                            "197000110"
                                   MOVE   "197000470"
                                           TO  WRK-SKJ5-TOKU-SHOKU(IDX3)
                               END-IF
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                           TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
      *                    流動食
                           WHEN   3
                               EVALUATE   WRK-SYS5000-SHOKUCD(1 IDX1)
      *                            入院時食事療養費（１）
                                   WHEN   "197000110"
                                      MOVE   "197003110"
                                              TO  WRK-SKJ4-RYOYO(IDX3)
      *                            入院時食事療養費（２）
                                   WHEN   "197000710"
                                      MOVE   "197003210"
                                              TO  WRK-SKJ4-RYOYO(IDX3)
                               END-EVALUATE
                               IF   WRK-SYS5000-SHOKUCD(1 IDX1) NOT =
                                                                 SPACE
                                   MOVE   "197000810"
                                         TO  WRK-SKJFTN2-SRYCD(IDX3)
                               END-IF
                       END-EVALUATE
                       IF    WRK-SYS5000-SHOKUCD(3 IDX1)  NOT = SPACE
                           MOVE  WRK-SYS5000-SHOKUCD(3 IDX1)
                                          TO  WRK-SKJ6-SHOKUDOU(IDX1)
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"             TO  MCP-TABLE
           MOVE    "key32"                     TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *     DISPLAY "---------SKJ4 SKJ2 CLEAR MAE -----------------"
      *     PERFORM    VARYING  IDX1   FROM 1 BY 1
      *       UNTIL    IDX1 > 93
      *           DISPLAY  "IDX1 = " IDX1
      *                    " WRK-SKJ4-HKNCOMBI-DAY = "
      *                    WRK-SKJ4-HKNCOMBI-DAY(IDX1)
      *                    " WRK-SKJFTN2-HKNCOMBI-DAY = "
      *                    WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)
      *     END-PERFORM
      *
      *    引数でセットされた保険組合せ番号以外はSKJ4,SKJ5,SKJFTN2
      *    領域のセット内容をクリアする
           PERFORM    VARYING  IDX1   FROM 1 BY 1
             UNTIL    IDX1 > 93
                 IF   WRK-SKJ4-HKNCOMBI-DAY(IDX1)  NOT =  ZERO
                   IF   WRK-SKJ4-HKNCOMBI-DAY(IDX1)  =
                                  LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(10)
                       CONTINUE
                   ELSE
                       MOVE    SPACE   TO   WRK-SKJ4-TBL(IDX1)
                       INITIALIZE           WRK-SKJ4-TBL(IDX1)
                   END-IF
                 END-IF
                 IF   WRK-SKJ5-HKNCOMBI-DAY(IDX1)  NOT =  ZERO
                   IF   WRK-SKJ5-HKNCOMBI-DAY(IDX1)  =
                                  LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(10)
                       CONTINUE
                   ELSE
                       MOVE    SPACE   TO   WRK-SKJ5-TBL(IDX1)
                       INITIALIZE           WRK-SKJ5-TBL(IDX1)
                   END-IF
                 END-IF
                 IF   WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)  NOT =  ZERO
                   IF   WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)  =
                                  LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(10)
                       CONTINUE
                   ELSE
                       MOVE    SPACE   TO   WRK-SKJFTN2-TBL(IDX1)
                       INITIALIZE           WRK-SKJFTN2-TBL(IDX1)
                   END-IF
                 END-IF
           END-PERFORM
      *     DISPLAY "---------SKJ4 SKJ2 CLEAR ATO -----------------"
      *     PERFORM    VARYING  IDX1   FROM 1 BY 1
      *       UNTIL    IDX1 > 93
      *           DISPLAY  "IDX1 = " IDX1
      *                    " WRK-SKJ4-HKNCOMBI-DAY = "
      *                    WRK-SKJ4-HKNCOMBI-DAY(IDX1)
      *                    " WRK-SKJFTN2-HKNCOMBI-DAY = "
      *                    WRK-SKJFTN2-HKNCOMBI-DAY(IDX1)
      *     END-PERFORM
      *
      *    同日再入院日に他保険で食事の算定がある場合に
      *    食堂加算をクリアする
           PERFORM      VARYING   IDX1   FROM   1  BY  1
             UNTIL      IDX1     >    31
                IF   LNK-NYUINDAY-DOUJITSU-HKNHENKBN(IDX1) = "1" 
                   IF  LNK-NYUINDAY-DOUJITSU-HKNCOMBI(IDX1) =
                                  LNK-DPCNYUIN-SET-HKNCOMBI(1)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(2)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(3)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(4)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(5)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(6)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(7)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(8)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(9)  OR
                                  LNK-DPCNYUIN-SET-HKNCOMBI(10)
                      IF   WRK-SKJ-HKNCOMBI-ASA(IDX1)  NOT =  ZERO
                           CONTINUE
                      END-IF
                      IF   WRK-SKJ-HKNCOMBI-HIRU(IDX1)  NOT =  ZERO
                        IF (WRK-SKJ-HKNCOMBI-ASA(IDX1)  =  ZERO  AND
                            WRK-SKJ-ASA-ARI(IDX1)       NOT = ZERO)
                                   MOVE   "1"  TO
                                        WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
                        END-IF
                      END-IF
                      IF   WRK-SKJ-HKNCOMBI-YORU(IDX1)  NOT =  ZERO
                        IF (WRK-SKJ-HKNCOMBI-ASA(IDX1)  =  ZERO  AND
                            WRK-SKJ-ASA-ARI(IDX1)       NOT = ZERO) OR
                           (WRK-SKJ-HKNCOMBI-HIRU(IDX1)  =  ZERO  AND
                            WRK-SKJ-HIRU-ARI(IDX1)      NOT = ZERO)
                                   MOVE   "1"  TO
                                        WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
                        END-IF
                      END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    同日再入院日に他保険で食事の算定がある場合に
      *    食堂加算をクリアする
           PERFORM      VARYING   IDX1   FROM   1  BY  1
             UNTIL      IDX1     >    31
                IF   LNK-NYUINDAY-DOUJITSU-KBN(IDX1)  =  "1"
      *            朝食を他保険で算定
                   IF  WRK-SKJ-ASA-ARI(IDX1)  NOT =  ZERO
                      IF   WRK-SKJ-HKNCOMBI-ASA(IDX1)   =  ZERO
                          MOVE   "1"  TO  WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
                      END-IF
                   END-IF
      *            朝食又は昼食を他保険で算定
                   IF (WRK-SKJ-ASA-ARI(IDX1)   NOT =  ZERO)  OR
                      (WRK-SKJ-HIRU-ARI(IDX1)  NOT =  ZERO)
                      IF  (WRK-SKJ-HKNCOMBI-ASA(IDX1)   =  ZERO) AND
                          (WRK-SKJ-HKNCOMBI-HIRU(IDX1)  =  ZERO)
                          MOVE   "1"  TO  WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
                      END-IF
                   END-IF
               END-IF
           END-PERFORM
      **     PERFORM      VARYING   IDX1   FROM   1  BY  1
      **       UNTIL      IDX1     >    31
      **        DISPLAY "IDX1 = " IDX1 " WRK-TAHOKEN-SHOKUDOU-FLG(IDX1) ="
      **                WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
      **     END-PERFORM
      *
      *    同日再入院日の再入院分食事算定について、入退院日を変更する為
      *    の区分をセット
           PERFORM      VARYING   IDX1   FROM   1  BY  1
             UNTIL      IDX1     >    31
                MOVE    SPACE       TO   WRK-SAINYUINKBN-ASA(IDX1)
                MOVE    SPACE       TO   WRK-SAINYUINKBN-HIRU(IDX1)
                MOVE    SPACE       TO   WRK-SAINYUINKBN-YORU(IDX1)
                IF   LNK-NYUINDAY-DOUJITSU-KBN(IDX1)  =  "1"
      *            朝食
                   IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)   =  "1"
                       MOVE   "1"  TO  WRK-SAINYUINKBN-ASA(IDX1)
                   END-IF
      *            昼食
                   IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)   =  "1" OR
                                                                "2"
                       MOVE   "1"  TO  WRK-SAINYUINKBN-HIRU(IDX1)
                   END-IF
      *            夕食
                   IF   LNK-NYUINDAY-DOUJITSU-SKJKBN(IDX1)   =  "1" OR
                                                                "2" OR
                                                                "3"
                       MOVE   "1"  TO  WRK-SAINYUINKBN-YORU(IDX1)
                   END-IF
               END-IF
      **         DISPLAY "IDX1 = " IDX1
      **         DISPLAY "ASA  = " WRK-SKJ-HKNCOMBI-ASA(IDX1)
      **         DISPLAY "HIRU = " WRK-SKJ-HKNCOMBI-HIRU(IDX1)
      **         DISPLAY "YORU = " WRK-SKJ-HKNCOMBI-YORU(IDX1)
      **         DISPLAY "DOUJITSU-KBN = " LNK-NYUINDAY-DOUJITSU-KBN(IDX1)
      **                 " LNK-SKJHKN = "LNK-SKJHKN-HKNCOMBINUM(IDX1 2)
      **             " WRK-SAINYUINKBN-ASA = " WRK-SAINYUINKBN-ASA(IDX1)
      **             " WRK-SAINYUINKBN-HIRU = " WRK-SAINYUINKBN-HIRU(IDX1)
      **             " WRK-SAINYUINKBN-YORU = " WRK-SAINYUINKBN-YORU(IDX1)
           END-PERFORM
      *
      *    食堂加算クリアフラグによる食堂加算領域のクリア
           PERFORM      VARYING   IDX1   FROM   1  BY  1
             UNTIL      IDX1     >    31
      **       DISPLAY "IDX1 = " IDX1 " WRK-TAHOKEN-SHOKUDOU-FLG = "
      **                                WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)
      **                       " SHOKUDOU = "
      **                                WRK-SKJ6-SHOKUDOU(IDX1)
             IF    WRK-TAHOKEN-SHOKUDOU-FLG(IDX1)  =   "1"
                 MOVE    SPACE     TO  WRK-SKJ6-SHOKUDOU(IDX1)
             END-IF
           END-PERFORM
      *
      *−−−−サブルーチンでの患者所得情報の取得ここから−−−−−
           INITIALIZE                          WRK-SYOTOKU-SKJKBN-AREA
           INITIALIZE                          ORCSSYOTOKUAREA
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  LNK-SYOTOKU-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  LNK-SYOTOKU-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  LNK-SYOTOKU-SRYYM
           MOVE    "1"                     TO  LNK-SYOTOKU-SKJCHKFLG
           CALL    "ORCSSYOTOKU"    USING      ORCSSYOTOKUAREA
                                               SPA-AREA
           IF    LNK-SYOTOKU-RC      =         ZERO
                PERFORM    VARYING   IDX1   FROM   1   BY  1
                  UNTIL   (IDX1      >     31)
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX1)
                      COMPUTE    IDX2   =   IDX1   +   31
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX2)
                      COMPUTE    IDX2   =   IDX1   +   62
                      MOVE    LNK-SYOTOKU-SKJKBN(IDX1)
                                    TO  WRK-SYOTOKU-SKJKBN (IDX2)
                END-PERFORM
           ELSE
                DISPLAY "ORCSSYTOKU RC = " LNK-SYOTOKU-RC
           END-IF
      *−−−−サブルーチンでの患者所得情報の取得ここまで−−−−−
      *
      *所得情報のセット
           PERFORM   VARYING   IDX1   FROM   1  BY  1
                     UNTIL     IDX1   >    93
               IF    WRK-SKJ4-RYOYO(IDX1)  NOT =  SPACE
                   EVALUATE    WRK-SYOTOKU-SKJKBN (IDX1)
      *                低所得２
                       WHEN    "2"
                           MOVE   "197000910"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
      *                低所得２（９０日越え）
                       WHEN    "3"
                           MOVE   "197001010"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
      *                低所得１
                       WHEN    "1"
                       WHEN    "4"
                           MOVE   "197001110"
                                         TO  WRK-SKJFTN2-SRYCD(IDX1)
                   END-EVALUATE
               END-IF
           END-PERFORM
      *
      *
      *
      *    入院時生活療養費の情報取得
           INITIALIZE                        ORCSNYULIFE2-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM  TO  LNK-NYULIFE2-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID     TO  LNK-NYULIFE2-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM TO  LNK-NYULIFE2-SANTEIYM
           CALL    "ORCSNYULIFE2"     USING  ORCSNYULIFE2-AREA
                                             SPA-AREA
           IF      LNK-NYULIFE2-RC          NOT =  ZERO
               DISPLAY  "LNK-NYULIFE2-RC = " LNK-NYULIFE2-RC
           END-IF
      *
      *    食事負担据え置き対象取得サブ
           INITIALIZE                          ORCSSKJKEEP-AREA
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  LNK-SKJKEEP-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  LNK-SKJKEEP-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  LNK-SKJKEEP-SANTEIYM
           CALL    "ORCSSKJKEEP"    USING      ORCSSKJKEEP-AREA
                                               SPA-AREA
      *
      *    食事ワーク７の編集（同一剤まとめ用）
      *    ※添字の３２から６２は同日再入院編集用
           PERFORM      VARYING    IDX1   FROM   1  BY  1
                        UNTIL      IDX1   >   31
      *        食事療養費（朝）
               MOVE     ZERO          TO  SET-IDX1
      **         DISPLAY "ASA"
      **         DISPLAY "WRK-SKJ4-RYOYO(IDX1) = " WRK-SKJ4-RYOYO(IDX1)
               IF   WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE
      *
      *            同日再入院の食事は編集先を変更
                   MOVE  IDX1          TO  SET-IDX1
                   IF   WRK-SAINYUINKBN-ASA(IDX1)  =   "1"
                        COMPUTE  SET-IDX1  =   IDX1  +  31
                   ELSE
                        MOVE     IDX1      TO  SET-IDX1
                   END-IF
      *
      *            同日再入院の食事判定用
                   IF   WRK-SAINYUINKBN-ASA(IDX1)   =   "1"
                        MOVE    1   TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
                   IF   SET-IDX1     >=    32
                        MOVE    1   TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
      *
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  =   SPACE
                     MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
                                    TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                     IF   WRK-SKJ4-RYOYO(IDX1)   =   CONS-SKJ-RYOYO-1-1
                                                 OR  CONS-SKJ-RYOYO-2-1
                         MOVE  WRK-SKJ4-RYOYO(IDX1)
                                         TO  WRK-SKJ7-RYOYO(SET-IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                     END-IF
                     IF   WRK-SKJ4-RYOYO(IDX1)   =   CONS-SKJ-RYOYO-1-2
                                                 OR  CONS-SKJ-RYOYO-2-2
                         MOVE  WRK-SKJ4-RYOYO(IDX1)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                          ADD   1    TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                     END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX1)
                                     TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)
                                       TO  WRK-SKJ7-RYOYO(SET-IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                           ADD   1   TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（朝）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX1)
                                       TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                       MOVE  "197001570"
                                    TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
                   END-IF
                   ADD   1          TO  WRK-SKJ7-TOKU-SHOKU-SU(SET-IDX1)
               END-IF
      *        食事負担（朝）
               IF    WRK-SKJFTN2-SRYCD(IDX1)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX1)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SYOTOKU-SKJKBN(IDX1)  =  SPACE
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                           MOVE   CONS-NANBYO-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                           MOVE   CONS-SEISIN-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 1)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(SET-IDX1)
               END-IF
      *        食堂加算
      **         DISPLAY "=====  SHOUDOU ASA ========"
      **         DISPLAY "IDX1 = " IDX1
      **         DISPLAY "WRK-SKJ6-SHOKUDOU(IDX1) = " 
      **                  WRK-SKJ6-SHOKUDOU(IDX1)
      **         DISPLAY "SET-IDX1 = " SET-IDX1
               IF    (WRK-SKJ6-SHOKUDOU(IDX1)  NOT =   SPACE)  AND
                     (SET-IDX1     NOT =   ZERO)
                   MOVE  WRK-SKJ6-SHOKUDOU(IDX1)
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF  (LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) = SPACE)
                         CONTINUE
                   ELSE
                       MOVE  "197001670"
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
                   END-IF
                   MOVE    SPACE       TO  WRK-SKJ6-SHOKUDOU(IDX1)
               END-IF
      *        食事療養費（昼）
               MOVE      ZERO          TO  IDX2
               MOVE      ZERO          TO  SET-IDX1
               COMPUTE   IDX2     =    IDX1    +   31
      **         DISPLAY "HIRU"
      **         DISPLAY "WRK-SKJ4-RYOYO(IDX2) = " WRK-SKJ4-RYOYO(IDX2)
               IF    WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE
      *
      *            同日再入院の食事は編集先を変更
                   MOVE  IDX1          TO  SET-IDX1
                   IF   WRK-SAINYUINKBN-HIRU(IDX1)  =   "1"
                        COMPUTE  SET-IDX1  =   IDX1  +  31
                   ELSE
                        MOVE     IDX1      TO  SET-IDX1
                   END-IF
      *
      *            同日再入院の食事判定用
                   IF   WRK-SAINYUINKBN-HIRU(IDX1)   =   "1"
                        MOVE    1   TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
                   IF   SET-IDX1     >=    32
                        MOVE    1    TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
      *
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  =   SPACE
                     MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
                                     TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                     IF   WRK-SKJ4-RYOYO(IDX2)   =   CONS-SKJ-RYOYO-1-1
                                                 OR  CONS-SKJ-RYOYO-2-1
                         MOVE  WRK-SKJ4-RYOYO(IDX2)
                                         TO  WRK-SKJ7-RYOYO(SET-IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                     END-IF
                     IF   WRK-SKJ4-RYOYO(IDX2)   =   CONS-SKJ-RYOYO-1-2
                                                 OR  CONS-SKJ-RYOYO-2-2
                         MOVE  WRK-SKJ4-RYOYO(IDX2)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                         ADD   1     TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                     END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX2)
                                     TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)
                                       TO  WRK-SKJ7-RYOYO(SET-IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                           ADD   1   TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（昼）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX2)
                                       TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                       MOVE  "197001570"
                                    TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
                   END-IF
                   ADD   1          TO  WRK-SKJ7-TOKU-SHOKU-SU(SET-IDX1)
               END-IF
      *        食事負担（昼）
               IF    WRK-SKJFTN2-SRYCD(IDX2)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX2)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SYOTOKU-SKJKBN(IDX1)  =  SPACE
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                           MOVE   CONS-NANBYO-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                           MOVE   CONS-SEISIN-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 2)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 2)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(SET-IDX1)
               END-IF
      *        食堂加算
      **         DISPLAY "=====  SHOUDOU HIRU ========"
      **         DISPLAY "IDX1 = " IDX1
      **         DISPLAY "WRK-SKJ6-SHOKUDOU(IDX1) = " 
      **                  WRK-SKJ6-SHOKUDOU(IDX1)
      **         DISPLAY "SET-IDX1 = " SET-IDX1
               IF    (WRK-SKJ6-SHOKUDOU(IDX1)  NOT =   SPACE)  AND
                     (SET-IDX1     NOT =   ZERO)
                   MOVE  WRK-SKJ6-SHOKUDOU(IDX1)
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF  (LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) = SPACE)
                         CONTINUE
                   ELSE
                       MOVE  "197001670"
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
                   END-IF
                   MOVE    SPACE       TO  WRK-SKJ6-SHOKUDOU(IDX1)
               END-IF
      *        食事療養費（夕）
               MOVE      ZERO          TO  IDX3
               MOVE      ZERO          TO  SET-IDX1
               COMPUTE   IDX3     =    IDX1    +   62
      **         DISPLAY "YORU"
      **         DISPLAY "WRK-SKJ4-RYOYO(IDX3) = " WRK-SKJ4-RYOYO(IDX3)
               IF    WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE
      *
      *            同日再入院の食事は編集先を変更
                   MOVE  IDX1          TO  SET-IDX1
                   IF   WRK-SAINYUINKBN-YORU(IDX1)  =   "1"
                        COMPUTE  SET-IDX1  =   IDX1  +  31
                   ELSE
                        MOVE     IDX1      TO  SET-IDX1
                   END-IF
      *
      *            同日再入院の食事判定用
                   IF   WRK-SAINYUINKBN-YORU(IDX1)   =   "1"
                        MOVE    1   TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
                   IF   SET-IDX1     >=    32
                        MOVE    1   TO   WRK-SKJ7-SAINYUINKBN(SET-IDX1)
                   END-IF
      *
                   IF  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  =   SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
                                     TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                      IF   WRK-SKJ4-RYOYO(IDX3)   =   CONS-SKJ-RYOYO-1-1
                                                  OR  CONS-SKJ-RYOYO-2-1
                          MOVE  WRK-SKJ4-RYOYO(IDX3)
                                          TO  WRK-SKJ7-RYOYO(SET-IDX1)
                          ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                      END-IF
                      IF   WRK-SKJ4-RYOYO(IDX3)   =   CONS-SKJ-RYOYO-1-2
                                                  OR  CONS-SKJ-RYOYO-2-2
                          MOVE  WRK-SKJ4-RYOYO(IDX3)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                          ADD   1    TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                      END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                      MOVE  WRK-SKJ4-HKNCOMBI-DAY(IDX3)
                                     TO  WRK-SKJ7-HKNCOMBI-DAY(SET-IDX1)
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) =
                                               CONS-SKJSEI-RYOYO-1-1 OR
                                               CONS-SKJSEI-RYOYO-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)
                                       TO  WRK-SKJ7-RYOYO(SET-IDX1)
                           ADD   1     TO  WRK-SKJ7-RYOYO-SU(SET-IDX1)
                      END-IF
                      IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) =
                                               CONS-SKJSEI-RYOYO-1-2
                           MOVE  LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)
                                     TO  WRK-SKJ7-RYOYO-RYU(SET-IDX1)
                           ADD   1   TO  WRK-SKJ7-RYOYO-RYU-SU(SET-IDX1)
                      END-IF
                   END-IF
               END-IF
      *        特別食加算（夕）
               IF    WRK-SKJ5-TOKU-SHOKU(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJ5-TOKU-SHOKU(IDX3)
                                       TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                       MOVE  "197001570"
                                    TO  WRK-SKJ7-TOKU-SHOKU(SET-IDX1)
                   END-IF
                   ADD   1          TO  WRK-SKJ7-TOKU-SHOKU-SU(SET-IDX1)
               END-IF
      *        食事負担（夕）
               IF    WRK-SKJFTN2-SRYCD(IDX3)  NOT =   SPACE
                   MOVE  WRK-SKJFTN2-SRYCD(IDX3)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
      *            難病等と精神１年超の置き換え
                   IF    LNK-SYOTOKU-SKJKBN(IDX1)  =  SPACE
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "1"
                           MOVE   CONS-NANBYO-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                       IF    LNK-SKJKEEP-KBN(IDX1)    =   "2"
                           MOVE   CONS-SEISIN-SKJFTN
                                           TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                       END-IF
                   END-IF
      *            入院時生活療養費の置換え
                   IF   LNK-NYULIFE2-SKJ-SRYCD(IDX1 3)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-SKJFTN-SRYCD(IDX1 3)
                                       TO  WRK-SKJ7-SKJFTN(SET-IDX1)
                   END-IF
                   ADD   1             TO  WRK-SKJ7-SKJFTN-SU(SET-IDX1)
               END-IF
      *        食事回数
      **         IF    (WRK-SKJ4-RYOYO(IDX1)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX2)  NOT =   SPACE)   AND
      **               (WRK-SKJ4-RYOYO(IDX3)  NOT =   SPACE)
      **             MOVE      1         TO   WRK-SKJ7-KAISU(IDX1)
      **         END-IF
      *        食堂加算
      **         DISPLAY "=====  SHOUDOU YORU ========"
      **         DISPLAY "IDX1 = " IDX1
      **         DISPLAY "WRK-SKJ6-SHOKUDOU(IDX1) = " 
      **                  WRK-SKJ6-SHOKUDOU(IDX1)
      **         DISPLAY "SET-IDX1 = " SET-IDX1
               IF    (WRK-SKJ6-SHOKUDOU(IDX1)  NOT =   SPACE)  AND
                     (SET-IDX1     NOT =   ZERO)
                   MOVE  WRK-SKJ6-SHOKUDOU(IDX1)
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
      *            入院時生活療養費の置換え
                   IF  (LNK-NYULIFE2-SKJ-SRYCD(IDX1 1) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 2) = SPACE) AND
                       (LNK-NYULIFE2-SKJ-SRYCD(IDX1 3) = SPACE)
                         CONTINUE
                   ELSE
                       MOVE  "197001670"
                                       TO  WRK-SKJ7-SHOKUDOU(SET-IDX1)
                   END-IF
                   MOVE    SPACE       TO  WRK-SKJ6-SHOKUDOU(IDX1)
               END-IF
           END-PERFORM
      *
      *    食事の診療コード計
           PERFORM    VARYING   IDX1    FROM  1  BY  1
                      UNTIL     IDX1    >   62
               IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-RYOYO(IDX1)       TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-RYOYO-RYU(IDX1)   TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                   MOVE    WRK-SKJ7-SHOKUDOU(IDX1)    TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
      **         IF   WRK-SKJ7-TOKU-SHOKU(IDX1)  NOT =  SPACE
      **             MOVE    WRK-SKJ7-TOKU-SHOKU(IDX1)  TO WRK-SRYCD-X
      **             COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
      **                     WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
      **         END-IF
               IF   WRK-SKJ7-SKJFTN(IDX1)      NOT =  SPACE
                   MOVE    WRK-SKJ7-SKJFTN(IDX1)  TO WRK-SRYCD-X
                   COMPUTE WRK-SKJ7-SRYCDTOTAL(IDX1)  =
                           WRK-SKJ7-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
               END-IF
               ADD   WRK-SKJ7-RYOYO-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               ADD   WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
      **         ADD   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      **                               TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               EVALUATE    WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
                   WHEN    1
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
                   WHEN    2
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
                   WHEN    3
                       ADD  1   TO   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
               END-EVALUATE
               ADD   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     TO  WRK-SKJ7-SRYCDTOTAL(IDX1)
               IF    IDX1     >=     32
                   COMPUTE   IDX2    =    IDX1   -  31
               ELSE
                   MOVE      IDX1    TO   IDX2
               END-IF
           END-PERFORM
      *
      *     DISPLAY "WRK-SKJ7  MATOME BEFORE"
      *     PERFORM      VARYING    IDX1   FROM   1  BY  1
      *                  UNTIL      IDX1   >   62
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
      *          DISPLAY "WRK-SKJ7-SRYCDTOTAL =(IDX1) = "
      *                   WRK-SKJ7-SRYCDTOTAL (IDX1)
      *          DISPLAY "WRK-SKJ7-SAINYUINKBN =(IDX1) = "
      *                   WRK-SKJ7-SAINYUINKBN (IDX1)
      *     END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの食事セット
           MOVE       ZERO    TO   IDX2
           MOVE       ZERO    TO   IDX3
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     62)
      *           DISPLAY "LNK-DPCNYUIN-SET"
      *           DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7  MATOME AFTER"
      *          DISPLAY "IDX1 = " IDX1
      *          DISPLAY "WRK-SKJ7-HKNCOMBI-DAY(IDX1) = "
      *                   WRK-SKJ7-HKNCOMBI-DAY(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO(IDX1) = "
      *                   WRK-SKJ7-RYOYO(IDX1)
      *          DISPLAY "WRK-SKJ7-RYOYO-SU(IDX1) = "
      *                   WRK-SKJ7-RYOYO-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-SHOKUDOU(IDX1) = "
      *                   WRK-SKJ7-SHOKUDOU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-SU(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)
      *          DISPLAY "WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) = "
      *                   WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN(IDX1) = "
      *                   WRK-SKJ7-SKJFTN(IDX1)
      *          DISPLAY "WRK-SKJ7-SKJFTN-SU(IDX1) = "
      *                   WRK-SKJ7-SKJFTN-SU(IDX1)
      *          DISPLAY "WRK-SKJ7-KAISU =(IDX1) = "
      *                   WRK-SKJ7-KAISU (IDX1)
              IF   (WRK-SKJ7-RYOYO(IDX1)       NOT =  SPACE)  OR
                   (WRK-SKJ7-RYOYO-RYU(IDX1)   NOT =  SPACE)
                IF (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001310")  AND
                   (WRK-SKJ7-RYOYO(IDX1)   NOT = "197001710")  AND
                   (WRK-SKJ7-RYOYO-RYU(IDX1)   NOT = "197003510")
      *-----------------------------------------------
      **              MOVE    IDX1     TO    IDX2
                    ADD     1        TO    IDX2
      *-----------------------------------------------
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(3 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    END-IF
      *             同日再入院判定項目
                    IF      WRK-SKJ7-SAINYUINKBN(IDX1)    =   1
                        MOVE  "1"  TO  LNK-DPCNYUIN-SAINYUINKBN
                                                        (3 IDX2 IDX4)
                    END-IF
      *             返却値に対象日付追加
                    IF       IDX1    >=   32
                         COMPUTE  LNK-DPCNYUIN-DD(3 IDX2)  =
                                  IDX1   -  31
                    ELSE
                        MOVE  IDX1    TO   LNK-DPCNYUIN-DD(3 IDX2)
                    END-IF
      *
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
      *               入院時食事療養（１）
                      WHEN  "197000110"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   640     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1280     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1920     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時食事療養（２）
                      WHEN  "197000710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   506     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1012     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1518     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
                    END-EVALUATE
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
      **                  IF     IDX4   =   1
                              MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO-RYU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE      WRK-SKJ7-RYOYO-RYU-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                    END-IF
                    EVALUATE  WRK-SKJ7-RYOYO-RYU(IDX1)
      *               入院時食事療養（１）（流動食）
                      WHEN  "197003110"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   575     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE  1150     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1725     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *               入院時食事療養（２）（流動食）
                      WHEN  "197003210"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   455     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE   910     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1365     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                        END-EVALUATE
      *                 平成３０年４月改正
                        IF    LNK-DPCNYUIN-SANTEIYM  >=  "201804"
                          EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   460     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  2
                                MOVE   920     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                            WHEN  3
                                MOVE  1380     TO  
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                          END-EVALUATE
                        END-IF
                    END-EVALUATE
                    IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(3 IDX2 IDX4)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(3 IDX2 IDX4)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(3 IDX2 IDX4)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               食事療養標準負担額（一般）
                            WHEN   "197000810"
                              IF  (LNK-DPCNYUIN-SANTEIYM
                                                        >= "201604") AND
                                  (LNK-DPCNYUIN-SANTEIYM
                                                        <= "201803")
                                 EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     WHEN   1
                                       MOVE  360  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   2
                                       MOVE  720  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   3
                                       MOVE 1080  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                 END-EVALUATE
                              END-IF
                              IF  (LNK-DPCNYUIN-SANTEIYM
                                                        >= "201804")
                                 EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                     WHEN   1
                                       MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   2
                                       MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                     WHEN   3
                                       MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                 END-EVALUATE
                              END-IF
      *               食事療養標準負担額（指定難病・小児慢性特定疾病患者）（一般）
                            WHEN   "197003310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（精神１年超）（一般）
                            WHEN   "197003410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日以下）
                            WHEN   "197000910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低２・９０日超）
                            WHEN   "197001010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *               食事療養標準負担額（低１）
                            WHEN   "197001110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(3 IDX2 IDX4)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(3 IDX2 IDX4)
                    END-IF
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(3 IDX2)
                ELSE
      *             入院時生活療養の食事療養は添字４の領域に返却
      *-----------------------------------------------
      **              MOVE   IDX1       TO    IDX3
                    ADD     1         TO    IDX3
      *              DISPLAY "IDX3 = " IDX3
      *-----------------------------------------------
                    MOVE  WRK-SKJ7-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(4 IDX3)
                    MOVE   ZERO     TO    IDX5
                    IF   WRK-SKJ7-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
      **                  IF     IDX5    =   1
                            MOVE   "97"   TO
                            LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE      WRK-SKJ7-RYOYO-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                    END-IF
      *             同日再入院判定項目
                    IF      WRK-SKJ7-SAINYUINKBN(IDX1)    =   1
                        MOVE  "1"  TO  LNK-DPCNYUIN-SAINYUINKBN
                                                        (4 IDX3 IDX5)
                    END-IF
      *             返却値に対象日付追加
                    IF       IDX1    >=   32
                         COMPUTE  LNK-DPCNYUIN-DD(4 IDX3)  =
                                  IDX1   -  31
                    ELSE
                        MOVE  IDX1    TO   LNK-DPCNYUIN-DD(4 IDX3)
                    END-IF
      *
                    EVALUATE  WRK-SKJ7-RYOYO(IDX1)
      *               入院時生活療養（１）食事療養
                      WHEN  "197001310"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   554     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1108     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1662     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
      *               入院時生活療養（２）食事療養
                      WHEN  "197001710"
                        EVALUATE  WRK-SKJ7-RYOYO-SU(IDX1)
                            WHEN  1
                                MOVE   420     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE   840     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1260     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    IF   WRK-SKJ7-RYOYO-RYU(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
      **                  IF     IDX5    =   1
                            MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
      **                  END-IF
                        MOVE   WRK-SKJ7-RYOYO-RYU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE      WRK-SKJ7-RYOYO-RYU-SU(IDX1)  TO
                                      LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                    END-IF
                    EVALUATE  WRK-SKJ7-RYOYO-RYU(IDX1)
      *               入院時生活療養（１）食事療養（流動食）
                      WHEN  "197003510"
                        EVALUATE  WRK-SKJ7-RYOYO-RYU-SU(IDX1)
                            WHEN  1
                                MOVE   500     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  2
                                MOVE  1000     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                            WHEN  3
                                MOVE  1500     TO  
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                        END-EVALUATE
                    END-EVALUATE
                    MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    IF   WRK-SKJ7-SHOKUDOU(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-SHOKUDOU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   50     TO
                                 LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    IF   WRK-SKJ7-TOKU-SHOKU(IDX1)   =  SPACE
                          CONTINUE
                    ELSE
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   1    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   76     TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU1(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   2    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   152    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU2(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                      IF  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1) NOT = 0
                         ADD     1     TO    IDX5
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                         MOVE   WRK-SKJ7-TOKU-SHOKU(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                         MOVE   3    TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                         MOVE   228    TO
                                      LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                         MOVE  WRK-SKJ7-TOKU-SHOKU-KAISU3(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                      END-IF
                    END-IF
                    IF   WRK-SKJ7-SKJFTN(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX5
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(4 IDX3 IDX5)
                       MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(4 IDX3 IDX5)
                        MOVE   WRK-SKJ7-SKJFTN-SU(IDX1)  TO
                                  LNK-DPCNYUIN-SURYO(4 IDX3 IDX5)
                        EVALUATE   WRK-SKJ7-SKJFTN(IDX1)
      *               生活療養（１）食事療養標準負担額（一般）
                            WHEN   "197002010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  460  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  920  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1380  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養（２）食事療養標準負担額（一般）
                            WHEN   "197002110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  840  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低２）
                            WHEN   "197002210"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（低１）
                            WHEN   "197002310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福以外））
                            WHEN   "197002410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  130  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  390  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（老人低１（老福））
                            WHEN   "197002510"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（一般））
                            WHEN   "197002710"
                              IF   LNK-DPCNYUIN-SANTEIYM
                                                        >= "201604"
                                EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  360  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  720  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE 1080  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                END-EVALUATE
                              END-IF
      *             （平成３０年改正）
      *               生活療養（１）食事療養標準負担額（医療区分２・３）（一般）
                            WHEN   "197005110"
                              EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                 WHEN   1
                                    MOVE  460  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                 WHEN   2
                                    MOVE  920  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                 WHEN   3
                                    MOVE 1380  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                              END-EVALUATE
      *             （平成３０年改正）
      *               生活療養（２）食事療養標準負担額（医療区分２・３）（一般）
                            WHEN   "197005210"
                              EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                 WHEN   1
                                    MOVE  420  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                 WHEN   2
                                    MOVE  840  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                 WHEN   3
                                    MOVE 1260  TO 
                                       LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                              END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（一般）
                            WHEN   "197003610"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（精神１年超・医療区分２・３）（一般）
                            WHEN   "197003710"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  260  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  520  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  780  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日以下））
                            WHEN   "197002810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低２・
      *                                           ９０日超））
                            WHEN   "197002910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２、３（低１））
                            WHEN   "197003010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               ここから平成２９年１０月コード追加分
      *               生活療養食事療養標準負担額（低）
                            WHEN   "197003910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（境界層該当）（低）
                            WHEN   "197004010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（境界層該当）（低１）
                            WHEN   "197004110"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２・３）（低・９０日以下）
                            WHEN   "197004210"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（低・９０日以下）
                            WHEN   "197004310"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（医療区分２・３）（低・９０日超）
                            WHEN   "197004410"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（低・９０日超）
                            WHEN   "197004510"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（境界層該当）（医療区分２・３）（低）
                            WHEN   "197004610"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（低２・９０日以下）
                            WHEN   "197004710"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  210  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  420  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  630  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（低２・９０日超）
                            WHEN   "197004810"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  160  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  320  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  480  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（指定難病）（医療区分２・３）（低１）
                            WHEN   "197004910"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *               生活療養食事療養標準負担額（境界層該当）（医療区分２・３）（低１）
                            WHEN   "197005010"
                               EVALUATE   WRK-SKJ7-SKJFTN-SU(IDX1)
                                   WHEN   1
                                      MOVE  100  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   2
                                      MOVE  200  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                                   WHEN   3
                                      MOVE  300  TO 
                                         LNK-DPCNYUIN-TEN(4 IDX3 IDX5)
                               END-EVALUATE
      *
                        END-EVALUATE
      *
                        MOVE  WRK-SKJ7-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(4 IDX3 IDX5)
                    END-IF
                    MOVE  IDX5  TO  LNK-DPCNYUIN-MEISAISU(4 IDX3)
                END-IF
              END-IF
           END-PERFORM
      *
           .
       2103-SHOKUJI-HENSHU5-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院時生活療養（環境療養）（平成１８年１０月から平成２８年３月迄）
      *****************************************************************
       2104-KANKYO-HENSHU-SEC        SECTION.
      *
           PERFORM   VARYING   IDX1    FROM   1   BY   1
             UNTIL   IDX1      >       31
               IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)            AND
                     (LNK-NYULIFE-KAN-SRYCD(IDX1)    NOT =  SPACE)  AND
                    ((WRK-NYUINKHN(IDX1) NOT =  SPACE)              OR
                     (LNK-NYUINDAY-KBN(IDX1)     =  "1"  ))         AND
                    ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                     (WRK-GAIHAKU-KBN(IDX1)  >=    4))
                   MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                     TO  WRK-KANKYO-HKNCOMBI-DAY(IDX1)
                   MOVE   LNK-NYULIFE-KAN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-RYOYO(IDX1)
                   MOVE   LNK-NYULIFE-KANFTN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-FTN(IDX1)
                   IF   LNK-NYULIFE-KAN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-KAN-SRYCD(IDX1) TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
                   IF   LNK-NYULIFE-KANFTN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE-KANFTN-SRYCD(IDX1)
                                                        TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
               END-IF
           END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの環境療養セット
           MOVE       ZERO    TO   IDX2
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
                IF    WRK-KANKYO-RYOYO(IDX1)   NOT =  SPACE
                    MOVE   IDX1     TO    IDX2
                    MOVE  WRK-KANKYO-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(5 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-KANKYO-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-KANKYO-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                    END-IF
                    EVALUATE  WRK-KANKYO-RYOYO(IDX1)
                      WHEN  "197001410"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                      WHEN  "197001810"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                    END-EVALUATE
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    IF   WRK-KANKYO-FTN(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
                         MOVE   WRK-KANKYO-FTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                         MOVE   320     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                         MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    END-IF
      *
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(5 IDX2)
                END-IF
           END-PERFORM
      *
           .
       2104-KANKYO-HENSHU-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院時生活療養（環境療養）（平成２８年４月から平成２９年９月迄）
      *    ロジックは 2104-KANKYO-HENSHU-SEC と同じで、ORCSNYULIFE が
      *    ORCSNYULIFE2 に変更のみ
      *****************************************************************
       2104-KANKYO-HENSHU2-SEC        SECTION.
      *
           PERFORM   VARYING   IDX1    FROM   1   BY   1
             UNTIL   IDX1      >       31
               IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)            AND
                     (LNK-NYULIFE2-KAN-SRYCD(IDX1)   NOT =  SPACE)  AND
                    ((WRK-NYUINKHN(IDX1) NOT =  SPACE)              OR
                     (LNK-NYUINDAY-KBN(IDX1)     =  "1"  ))         AND
                    ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                     (WRK-GAIHAKU-KBN(IDX1)  >=    4))
                   MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                     TO  WRK-KANKYO-HKNCOMBI-DAY(IDX1)
                   MOVE   LNK-NYULIFE2-KAN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-RYOYO(IDX1)
                   MOVE   LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-FTN(IDX1)
                   IF   LNK-NYULIFE2-KAN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-KAN-SRYCD(IDX1) TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
                   IF   LNK-NYULIFE2-KANFTN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                                                        TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
               END-IF
           END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの環境療養セット
           MOVE       ZERO    TO   IDX2
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
                IF    WRK-KANKYO-RYOYO(IDX1)   NOT =  SPACE
                    MOVE   IDX1     TO    IDX2
                    MOVE  WRK-KANKYO-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(5 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-KANKYO-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-KANKYO-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                    END-IF
                    EVALUATE  WRK-KANKYO-RYOYO(IDX1)
                      WHEN  "197001410"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                      WHEN  "197001810"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                    END-EVALUATE
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    IF   WRK-KANKYO-FTN(IDX1)  NOT =  SPACE
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
                         MOVE   WRK-KANKYO-FTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                         MOVE   320     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                         MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    END-IF
      *
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(5 IDX2)
                END-IF
           END-PERFORM
      *
           .
       2104-KANKYO-HENSHU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院時生活療養（環境療養）（平成２９年１０月以降）
      *****************************************************************
       2104-KANKYO-HENSHU3-SEC        SECTION.
      *
           PERFORM   VARYING   IDX1    FROM   1   BY   1
             UNTIL   IDX1      >       31
               IF    (WRK-HKNCOMBI-DAY(IDX1) NOT = ZERO)            AND
                     (LNK-NYULIFE2-KAN-SRYCD(IDX1)   NOT =  SPACE)  AND
                    ((WRK-NYUINKHN(IDX1) NOT =  SPACE)              OR
                     (LNK-NYUINDAY-KBN(IDX1)     =  "1"  ))         AND
                    ((WRK-GAIHAKU-KBN(IDX1)  =  ZERO) OR
                     (WRK-GAIHAKU-KBN(IDX1)  >=    4))
                   MOVE   WRK-HKNCOMBI-DAY(IDX1)
                                     TO  WRK-KANKYO-HKNCOMBI-DAY(IDX1)
                   MOVE   LNK-NYULIFE2-KAN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-RYOYO(IDX1)
                   MOVE   LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                                     TO  WRK-KANKYO-FTN(IDX1)
                   IF   LNK-NYULIFE2-KAN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-KAN-SRYCD(IDX1) TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
                   IF   LNK-NYULIFE2-KANFTN-SRYCD(IDX1)  NOT =  SPACE
                       MOVE  LNK-NYULIFE2-KANFTN-SRYCD(IDX1)
                                                        TO WRK-SRYCD-X
                       COMPUTE WRK-KANKYO-SRYCDTOTAL(IDX1)  =
                           WRK-KANKYO-SRYCDTOTAL(IDX1)  +  WRK-SRYCD-9
                   END-IF
               END-IF
           END-PERFORM
      *
      *
      *    レセ電サブ返却エリアへの環境療養セット
           MOVE       ZERO    TO   IDX2
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
                IF    WRK-KANKYO-RYOYO(IDX1)   NOT =  SPACE
                    MOVE   IDX1     TO    IDX2
                    MOVE  WRK-KANKYO-HKNCOMBI-DAY(IDX1) TO
                                    LNK-DPCNYUIN-HKNCOMBI(5 IDX2)
                    MOVE   ZERO     TO    IDX4
                    IF   WRK-KANKYO-RYOYO(IDX1)  NOT =  SPACE
                        ADD     1     TO    IDX4
                        MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
      **                  IF     IDX4    =   1
                            MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
      **                  END-IF
                        MOVE   WRK-KANKYO-RYOYO(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                    END-IF
                    EVALUATE  WRK-KANKYO-RYOYO(IDX1)
                      WHEN  "197001410"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                      WHEN  "197001810"
                          MOVE   398     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                    END-EVALUATE
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    IF   WRK-KANKYO-FTN(IDX1)   =  "197001910"
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
                         MOVE   WRK-KANKYO-FTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                         MOVE   370     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                         MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    END-IF
                    IF   WRK-KANKYO-FTN(IDX1)   =  "197003810"
                         ADD     1     TO    IDX4
                         MOVE   "SI"   TO
                              LNK-DPCNYUIN-RECSKB(5 IDX2 IDX4)
                         MOVE   "97"   TO
                              LNK-DPCNYUIN-SRYSKB(5 IDX2 IDX4)
                         MOVE   WRK-KANKYO-FTN(IDX1)  TO
                                  LNK-DPCNYUIN-SRYCD(5 IDX2 IDX4)
                         MOVE   200     TO  
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
      *                 平成３０年改正　医療区分２、３（１日３７０円）
                        IF   LNK-DPCNYUIN-SANTEIYM >=  "201804"
                             MOVE  370       TO
                                      LNK-DPCNYUIN-TEN(5 IDX2 IDX4)
                        END-IF
                         MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    END-IF
      *
                    MOVE  WRK-KANKYO-KAISU(IDX1)  TO
                                    LNK-DPCNYUIN-KAISU(5 IDX2 IDX4)
                    MOVE  IDX4  TO  LNK-DPCNYUIN-MEISAISU(5 IDX2)
                END-IF
           END-PERFORM
      *
           .
       2104-KANKYO-HENSHU3-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟番号（病棟区分）の編集処理
      *****************************************************************
       2105-BTUNUM-HENSHU-SEC        SECTION.
      *
           MOVE    SPACE                   TO  TABLE-BTUKBN
           INITIALIZE                          TABLE-BTUKBN
           MOVE    SPACE                   TO  TABLE-BTUKBN2
           INITIALIZE                          TABLE-BTUKBN2
      *    患者入院履歴の取得
           INITIALIZE                          PTNYUINRRK-REC
           MOVE    LNK-DPCNYUIN-HOSPNUM    TO  PTNYUINRRK-HOSPNUM
           MOVE    LNK-DPCNYUIN-PTID       TO  PTNYUINRRK-PTID
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  PTNYUINRRK-TENNYUYMD(1:6)
           MOVE    "99"                    TO  PTNYUINRRK-TENNYUYMD(7:2)
           MOVE    LNK-DPCNYUIN-SANTEIYM   TO  PTNYUINRRK-TENSTUYMD(1:6)
           MOVE    "01"                    TO  PTNYUINRRK-TENSTUYMD(7:2)
           MOVE    "tbl_ptnyuinrrk"        TO  MCP-TABLE
           MOVE    "key44"                 TO  MCP-PATHNAME
           PERFORM 910-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK          =   ZERO
               MOVE    "tbl_ptnyuinrrk"        TO  MCP-TABLE
               MOVE    "key44"             TO  MCP-PATHNAME
               PERFORM 910-PTNYUINRRK-READ-SEC
               PERFORM  UNTIL  
                  ( FLG-PTNYUINRRK         =   1  )
      *
      **           DISPLAY "PTNYUINRRK-FETCH"
      **           DISPLAY "PTNYUINRRK-TENNYUYMD = " PTNYUINRRK-TENNYUYMD
      **           DISPLAY "PTNYUINRRK-TENSTUYMD = " PTNYUINRRK-TENSTUYMD
                   MOVE    1     TO     IDX1
                   MOVE    31    TO     IDX2
                   IF      LNK-DPCNYUIN-SANTEIYM
                                     =   PTNYUINRRK-TENNYUYMD(1:6)
                       MOVE   PTNYUINRRK-TENNYUYMD(7:2)
                                         TO    WRK-DAY-X
                       MOVE   WRK-DAY-9  TO    IDX1
                   END-IF
                   IF      LNK-DPCNYUIN-SANTEIYM
                                     =   PTNYUINRRK-TENSTUYMD(1:6)
                       MOVE   PTNYUINRRK-TENSTUYMD(7:2)
                                         TO    WRK-DAY-X
                       MOVE   WRK-DAY-9  TO    IDX2
                   END-IF
      *
      **             DISPLAY "IDX1 = " IDX1
      **             DISPLAY "IDX2 = " IDX2
                   PERFORM   VARYING   IDX    FROM  IDX1   BY  1
                             UNTIL    (IDX    >   IDX2)
      *                 病棟番号セット（同日再入院日は別項目にセットする）
                        IF     TBL-BTUNUM(IDX)  =   ZERO
                          MOVE   PTNYUINRRK-RRKNUM  TO  TBL-RRKNUM(IDX)
                          MOVE   PTNYUINRRK-BTUNUM  TO  WRK-DAY-X
                          MOVE   WRK-DAY-9          TO  TBL-BTUNUM(IDX)
                          MOVE   PTNYUINRRK-NYUINKA TO  TBL-SRYKA(IDX)
                          MOVE   PTNYUINRRK-DRCD1   TO  TBL-DRCD(IDX)
                        ELSE
                          IF   PTNYUINRRK-RRKNUM    =   TBL-RRKNUM(IDX)
                            MOVE PTNYUINRRK-BTUNUM  TO  WRK-DAY-X
                            MOVE WRK-DAY-9          TO  TBL-BTUNUM(IDX)
                            MOVE PTNYUINRRK-NYUINKA TO  TBL-SRYKA(IDX)
                            MOVE PTNYUINRRK-DRCD1   TO  TBL-DRCD(IDX)
                          ELSE
                            MOVE PTNYUINRRK-BTUNUM  TO  WRK-DAY-X
                            MOVE WRK-DAY-9          TO  TBL-BTUNUM2(IDX)
                            MOVE PTNYUINRRK-NYUINKA TO  TBL-SRYKA2(IDX)
                            MOVE PTNYUINRRK-DRCD1   TO  TBL-DRCD2(IDX)
                          END-IF
                        END-IF
                   END-PERFORM
                   MOVE    "tbl_ptnyuinrrk"       TO  MCP-TABLE
                   MOVE    "key44"             TO  MCP-PATHNAME
                   PERFORM 910-PTNYUINRRK-READ-SEC
      *
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_ptnyuinrrk"      TO  MCP-TABLE
           MOVE    "key44"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *    病棟区分セット
           PERFORM   VARYING   IDX   FROM   1  BY  1
                     UNTIL    (IDX    >   31)
               IF   TBL-BTUNUM(IDX)    NOT =   ZERO
                   IF    IDX    >   1
                        COMPUTE   IDX3   =   IDX   -  1
                        IF    TBL-BTUNUM(IDX)   =  TBL-BTUNUM(IDX3)
                           MOVE  TBL-BTUKBN(IDX3)
                                          TO  TBL-BTUKBN(IDX)
                        ELSE
                           MOVE    ZERO           TO  FLG-SYSKANRI
                           INITIALIZE                 SYSKANRI-REC
                           MOVE    "5001"         TO  SYS-KANRICD
                           MOVE    TBL-BTUNUM(IDX)
                                                  TO  SYS-KBNCD
                           MOVE    LNK-DPCNYUIN-SANTEIYM
                                                  TO  SYS-STYUKYMD(1:6)
                           MOVE    "01"           TO  SYS-STYUKYMD(7:2)
                           MOVE    SYS-STYUKYMD   TO  SYS-EDYUKYMD
                           MOVE    SPA-HOSPNUM    TO  SYS-HOSPNUM
                           MOVE    SYSKANRI-REC   TO  MCPDATA-REC
                           MOVE    "tbl_syskanri" TO  MCP-TABLE
                           MOVE    "key10"        TO  MCP-PATHNAME
                           PERFORM   900-DBSELECT-SEC
                           IF      MCP-RC         =   ZERO
                               MOVE    "tbl_syskanri"
                                                  TO  MCP-TABLE
                               MOVE    "key10"    TO  MCP-PATHNAME
                               PERFORM  910-SYSKANRI-READ-SEC
                               MOVE     SYS-5001-BTU-SBT
                                                  TO  TBL-BTUKBN(IDX)
                           END-IF
                           MOVE    "tbl_syskanri" TO  MCP-TABLE
                           MOVE    "key10"        TO  MCP-PATHNAME
                           PERFORM   900-CLOSE-SEC
                        END-IF
                   ELSE
                        MOVE    ZERO              TO  FLG-SYSKANRI
                        INITIALIZE                    SYSKANRI-REC
                        MOVE    "5001"            TO  SYS-KANRICD
                        MOVE    TBL-BTUNUM(IDX)   TO  SYS-KBNCD
                        MOVE    LNK-DPCNYUIN-SANTEIYM
                                                  TO  SYS-STYUKYMD(1:6)
                        MOVE    "01"              TO  SYS-STYUKYMD(7:2)
                        MOVE    SYS-STYUKYMD      TO  SYS-EDYUKYMD
                        MOVE    SPA-HOSPNUM       TO  SYS-HOSPNUM
                        MOVE    SYSKANRI-REC      TO  MCPDATA-REC
                        MOVE    "tbl_syskanri"    TO  MCP-TABLE
                        MOVE    "key10"           TO  MCP-PATHNAME
                        PERFORM   900-DBSELECT-SEC
                        IF      MCP-RC            =   ZERO
                            MOVE    "tbl_syskanri" TO MCP-TABLE
                            MOVE    "key10"       TO  MCP-PATHNAME
                            PERFORM  910-SYSKANRI-READ-SEC
                            MOVE     SYS-5001-BTU-SBT
                                                  TO  TBL-BTUKBN(IDX)
                        END-IF
                        MOVE    "tbl_syskanri"    TO  MCP-TABLE
                        MOVE    "key10"           TO  MCP-PATHNAME
                        PERFORM   900-CLOSE-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
      *    病棟区分セット（同日再入院分）
           PERFORM   VARYING   IDX   FROM   1  BY  1
                     UNTIL    (IDX    >   31)
               IF   TBL-BTUNUM2(IDX)    NOT =   ZERO
                   IF    IDX    >   1
                        COMPUTE   IDX3   =   IDX   -  1
                        IF    TBL-BTUNUM2(IDX)   =  TBL-BTUNUM2(IDX3)
                           MOVE  TBL-BTUKBN2(IDX3)
                                          TO  TBL-BTUKBN2(IDX)
                        ELSE
                           MOVE    ZERO           TO  FLG-SYSKANRI
                           INITIALIZE                 SYSKANRI-REC
                           MOVE    "5001"         TO  SYS-KANRICD
                           MOVE    TBL-BTUNUM2(IDX)
                                                  TO  SYS-KBNCD
                           MOVE    LNK-DPCNYUIN-SANTEIYM
                                                  TO  SYS-STYUKYMD(1:6)
                           MOVE    "01"           TO  SYS-STYUKYMD(7:2)
                           MOVE    SYS-STYUKYMD   TO  SYS-EDYUKYMD
                           MOVE    SPA-HOSPNUM    TO  SYS-HOSPNUM
                           MOVE    SYSKANRI-REC   TO  MCPDATA-REC
                           MOVE    "tbl_syskanri" TO  MCP-TABLE
                           MOVE    "key10"        TO  MCP-PATHNAME
                           PERFORM   900-DBSELECT-SEC
                           IF      MCP-RC         =   ZERO
                               MOVE    "tbl_syskanri"
                                                  TO  MCP-TABLE
                               MOVE    "key10"    TO  MCP-PATHNAME
                               PERFORM  910-SYSKANRI-READ-SEC
                               MOVE     SYS-5001-BTU-SBT
                                                  TO  TBL-BTUKBN2(IDX)
                           END-IF
                           MOVE    "tbl_syskanri" TO  MCP-TABLE
                           MOVE    "key10"        TO  MCP-PATHNAME
                           PERFORM   900-CLOSE-SEC
                        END-IF
                   ELSE
                        MOVE    ZERO              TO  FLG-SYSKANRI
                        INITIALIZE                    SYSKANRI-REC
                        MOVE    "5001"            TO  SYS-KANRICD
                        MOVE    TBL-BTUNUM2(IDX)  TO  SYS-KBNCD
                        MOVE    LNK-DPCNYUIN-SANTEIYM
                                                  TO  SYS-STYUKYMD(1:6)
                        MOVE    "01"              TO  SYS-STYUKYMD(7:2)
                        MOVE    SYS-STYUKYMD      TO  SYS-EDYUKYMD
                        MOVE    SPA-HOSPNUM       TO  SYS-HOSPNUM
                        MOVE    SYSKANRI-REC      TO  MCPDATA-REC
                        MOVE    "tbl_syskanri"    TO  MCP-TABLE
                        MOVE    "key10"           TO  MCP-PATHNAME
                        PERFORM   900-DBSELECT-SEC
                        IF      MCP-RC            =   ZERO
                            MOVE    "tbl_syskanri" TO MCP-TABLE
                            MOVE    "key10"       TO  MCP-PATHNAME
                            PERFORM  910-SYSKANRI-READ-SEC
                            MOVE     SYS-5001-BTU-SBT
                                                  TO  TBL-BTUKBN2(IDX)
                        END-IF
                        MOVE    "tbl_syskanri"    TO  MCP-TABLE
                        MOVE    "key10"           TO  MCP-PATHNAME
                        PERFORM   900-CLOSE-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
      *     PERFORM    VARYING   SET-IDX1   FROM  1  BY  1
      *       UNTIL    SET-IDX1   >   31
      *         DISPLAY "SET-IDX1 = " SET-IDX1
      *         DISPLAY "TBL-BTUNUM = " TBL-BTUNUM(SET-IDX1)
      *         DISPLAY "TBL-BTUKBN = " TBL-BTUKBN(SET-IDX1)
      *         DISPLAY "TBL-SRYKA  = " TBL-SRYKA(SET-IDX1)
      *         DISPLAY "TBL-DRCD   = " TBL-DRCD(SET-IDX1)
      *         DISPLAY "TBL-BTUNUM2 = " TBL-BTUNUM2(SET-IDX1)
      *         DISPLAY "TBL-BTUKBN2 = " TBL-BTUKBN2(SET-IDX1)
      *         DISPLAY "TBL-SRYKA2  = " TBL-SRYKA2(SET-IDX1)
      *         DISPLAY "TBL-DRCD2   = " TBL-DRCD2(SET-IDX1)
      *     END-PERFORM
      *
      *    レセ電サブ返却エリアへのセット
           
           PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
      *         病棟番号セット（入院料）
      **          IF    LNK-DPCNYUIN-SRYCD(1 IDX1 1)   NOT =  SPACE
                    MOVE   TBL-BTUNUM(IDX1)   TO
                                          LNK-DPCNYUIN-BTUNUM(1 IDX1)
                    MOVE   TBL-BTUKBN(IDX1)   TO
                                          LNK-DPCNYUIN-BTUKBN(1 IDX1)
                    MOVE   TBL-SRYKA(IDX1)    TO
                                          LNK-DPCNYUIN-SRYKA(1 IDX1)
                    MOVE   TBL-DRCD(IDX1)     TO
                                          LNK-DPCNYUIN-DRCD(1 IDX1)
      **          END-IF
      *         病棟番号セット（特定入院料）
      **          IF    LNK-DPCNYUIN-SRYCD(2 IDX1 1)   NOT =  SPACE
                    MOVE   TBL-BTUNUM(IDX1)   TO
                                          LNK-DPCNYUIN-BTUNUM(2 IDX1)
                    MOVE   TBL-BTUKBN(IDX1)   TO
                                          LNK-DPCNYUIN-BTUKBN(2 IDX1)
                    MOVE   TBL-SRYKA(IDX1)    TO
                                          LNK-DPCNYUIN-SRYKA(2 IDX1)
                    MOVE   TBL-DRCD(IDX1)     TO
                                          LNK-DPCNYUIN-DRCD(2 IDX1)
      **          END-IF
      *         病棟番号セット（環境療養）
      **          IF    LNK-DPCNYUIN-SRYCD(5 IDX1 1)   NOT =  SPACE
                    MOVE   TBL-BTUNUM(IDX1)   TO
                                          LNK-DPCNYUIN-BTUNUM(5 IDX1)
                    MOVE   TBL-BTUKBN(IDX1)   TO
                                          LNK-DPCNYUIN-BTUKBN(5 IDX1)
                    MOVE   TBL-SRYKA(IDX1)    TO
                                          LNK-DPCNYUIN-SRYKA(5 IDX1)
                    MOVE   TBL-DRCD(IDX1)     TO
                                          LNK-DPCNYUIN-DRCD(5 IDX1)
      **          END-IF
           END-PERFORM
      *
           IF    LNK-DPCNYUIN-SANTEIYM  <=  "201709"
              PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     31)
      *         病棟番号セット（食事）
      **          IF    LNK-DPCNYUIN-SRYCD(3 IDX1 1)   NOT =  SPACE
                       MOVE   TBL-BTUNUM(IDX1)   TO
                                          LNK-DPCNYUIN-BTUNUM(3 IDX1)
                       MOVE   TBL-BTUKBN(IDX1)   TO
                                          LNK-DPCNYUIN-BTUKBN(3 IDX1)
                       MOVE   TBL-SRYKA(IDX1)    TO
                                          LNK-DPCNYUIN-SRYKA(3 IDX1)
                       MOVE   TBL-DRCD(IDX1)     TO
                                          LNK-DPCNYUIN-DRCD(3 IDX1)
      **          END-IF
      *         病棟番号セット（生活療養）
      **          IF    LNK-DPCNYUIN-SRYCD(4 IDX1 1)   NOT =  SPACE
                       MOVE   TBL-BTUNUM(IDX1)   TO
                                          LNK-DPCNYUIN-BTUNUM(4 IDX1)
                       MOVE   TBL-BTUKBN(IDX1)   TO
                                          LNK-DPCNYUIN-BTUKBN(4 IDX1)
                       MOVE   TBL-SRYKA(IDX1)    TO
                                          LNK-DPCNYUIN-SRYKA(4 IDX1)
                       MOVE   TBL-DRCD(IDX1)     TO
                                          LNK-DPCNYUIN-DRCD(4 IDX1)
      **          END-IF
              END-PERFORM
           ELSE
              PERFORM    VARYING   IDX1   FROM  1  BY  1
                      UNTIL     (IDX1   >     40)
      *         病棟番号セット（食事）
                IF   LNK-DPCNYUIN-DD(3 IDX1)  NOT =   ZERO
                     MOVE   LNK-DPCNYUIN-DD(3 IDX1)   TO  WRK-SET-DD
                     MOVE   TBL-BTUNUM(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUNUM(3 IDX1)
                     MOVE   TBL-BTUKBN(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUKBN(3 IDX1)
                     MOVE   TBL-SRYKA(WRK-SET-DD)    TO
                                          LNK-DPCNYUIN-SRYKA(3 IDX1)
                     MOVE   TBL-DRCD(WRK-SET-DD)     TO
                                          LNK-DPCNYUIN-DRCD(3 IDX1)
                     PERFORM   VARYING  IDX2 FROM  1 BY  1
                       UNTIL  (IDX2      >   100)    OR
                               (LNK-DPCNYUIN-SRYCD(3 IDX1 IDX2) = SPACE)
                             IF   LNK-DPCNYUIN-SAINYUINKBN(3 IDX1 IDX2)
                                                       =    "1"
                                MOVE   TBL-BTUNUM2(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUNUM2(3 IDX1)
                                MOVE   TBL-BTUKBN2(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUKBN2(3 IDX1)
                                MOVE   TBL-SRYKA2(WRK-SET-DD)    TO
                                          LNK-DPCNYUIN-SRYKA2(3 IDX1)
                                MOVE   TBL-DRCD2(WRK-SET-DD)     TO
                                          LNK-DPCNYUIN-DRCD2(3 IDX1)
                             END-IF
                     END-PERFORM
                END-IF
      *         病棟番号セット（生活療養）
                IF   LNK-DPCNYUIN-DD(4 IDX1)  NOT =   ZERO
                     MOVE   LNK-DPCNYUIN-DD(4 IDX1)   TO  WRK-SET-DD
                     MOVE   TBL-BTUNUM(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUNUM(4 IDX1)
                     MOVE   TBL-BTUKBN(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUKBN(4 IDX1)
                     MOVE   TBL-SRYKA(WRK-SET-DD)    TO
                                          LNK-DPCNYUIN-SRYKA(4 IDX1)
                     MOVE   TBL-DRCD(WRK-SET-DD)     TO
                                          LNK-DPCNYUIN-DRCD(4 IDX1)
                     PERFORM   VARYING  IDX2 FROM  1 BY  1
                       UNTIL  (IDX2      >   100)    OR
                               (LNK-DPCNYUIN-SRYCD(4 IDX1 IDX2) = SPACE)
                             IF   LNK-DPCNYUIN-SAINYUINKBN(4 IDX1 IDX2)
                                                       =    "1"
                                MOVE   TBL-BTUNUM2(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUNUM2(4 IDX1)
                                MOVE   TBL-BTUKBN2(WRK-SET-DD)   TO
                                          LNK-DPCNYUIN-BTUKBN2(4 IDX1)
                                MOVE   TBL-SRYKA2(WRK-SET-DD)    TO
                                          LNK-DPCNYUIN-SRYKA2(4 IDX1)
                                MOVE   TBL-DRCD2(WRK-SET-DD)     TO
                                          LNK-DPCNYUIN-DRCD2(4 IDX1)
                             END-IF
                     END-PERFORM
                END-IF
              END-PERFORM
           END-IF
      *
           .
       2105-BTUNUM-HENSHU-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ退避ワークチェック処理
      *****************************************************************
       910-TENSUWRK-CHK-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSUWRK
      *
           PERFORM VARYING TTNS-IDX      FROM    1   BY  1
                   UNTIL ( TTNS-IDX      >   TTNS-MAX ) OR
                         ( FLG-TENSUWRK    =   1 )      OR
                         ( TTNS-IDX      >   200 )
               IF    ( WRK-TENSU-SRYCD (TTNS-IDX)
                                       =   WRK-TENSU-CD )
                   MOVE    1           TO  FLG-TENSUWRK
                   MOVE    WRK-TENSU-DATA (TTNS-IDX)
                                       TO  TNS-TENSU-REC
               END-IF
           END-PERFORM
      *
           .
       910-TENSUWRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ退避ワーク編集処理
      *****************************************************************
       910-TTNS-HEN-SEC               SECTION.
      *
           IF    ( TTNS-CONST-MAX  >   TTNS-MAX )
               COMPUTE TTNS-MAX    =   TTNS-MAX    +   1
               MOVE    TNS-SRYCD       TO  WRK-TENSU-SRYCD
                                                   (TTNS-MAX)
               MOVE    TNS-TENSU-REC   TO  WRK-TENSU-DATA
                                                   (TTNS-MAX)
           END-IF
      *
           .
       910-TTNS-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5000-REC
                                               SYS-5001-REC
                                               SYS-1001-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                      SYS-5000-REC
                                               SYS-5001-REC
                                               SYS-1001-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   INITIALIZE              PTINF-REC
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    選定入院料振替マスター検索
      *****************************************************************
       910-SENTEICDCHG-SELECT-SEC        SECTION.
      *
           MOVE    SENTEICDCHG-REC     TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SENTEICDCHG
           ELSE
               MOVE    1                  TO  FLG-SENTEICDCHG
           END-IF
      *
           .
       910-SENTEICDCHG-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    選定入院料振替マスター読込
      *****************************************************************
       910-SENTEICDCHG-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SENTEICDCHG-REC
               MOVE    ZERO               TO  FLG-SENTEICDCHG
           ELSE
               INITIALIZE                     SENTEICDCHG-REC
               MOVE    1                  TO  FLG-SENTEICDCHG
           END-IF
      *
           .
       910-SENTEICDCHG-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得マスター検索
      *****************************************************************
       910-TSYRRK-SELECT-SEC        SECTION.
      *
           MOVE    TSYRRK-REC          TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-TSYRRK
           ELSE
               MOVE    1                  TO  FLG-TSYRRK
           END-IF
      *
           .
       910-TSYRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得マスター読込
      *****************************************************************
       910-TSYRRK-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  TSYRRK-REC
               MOVE    ZERO               TO  FLG-TSYRRK
           ELSE
               INITIALIZE                     TSYRRK-REC
               MOVE    1                  TO  FLG-TSYRRK
           END-IF
      *
           .
       910-TSYRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    低年金マスター検索
      *****************************************************************
       910-TNKRRK-SELECT-SEC        SECTION.
      *
           MOVE    TNKRRK-REC          TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-TNKRRK
           ELSE
               MOVE    1                  TO  FLG-TNKRRK
           END-IF
      *
           .
       910-TNKRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    低年金マスター読込
      *****************************************************************
       910-TNKRRK-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  TNKRRK-REC
               MOVE    ZERO               TO  FLG-TNKRRK
           ELSE
               INITIALIZE                     TNKRRK-REC
               MOVE    1                  TO  FLG-TNKRRK
           END-IF
      *
           .
       910-TNKRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター検索
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACT
           ELSE
               MOVE    1                  TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター読込
      *****************************************************************
       910-NYUINACT-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター検索
      *****************************************************************
       910-SRYACCT-SELECT-SEC        SECTION.
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SRYACCT
           ELSE
               MOVE    1                  TO  FLG-SRYACCT
           END-IF
      *
           .
       910-SRYACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       910-SRYACCT-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SRYACCT-REC
               MOVE    ZERO               TO  FLG-SRYACCT
           ELSE
               INITIALIZE                     SRYACCT-REC
               MOVE    1                  TO  FLG-SRYACCT
           END-IF
      *
           .
       910-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター検索
      *****************************************************************
       910-SRYACT-SELECT-SEC        SECTION.
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       910-SRYACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       910-SRYACT-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       910-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター検索
      *****************************************************************
       910-HKNCOMBI-SELECT-SEC        SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-HKNCOMBI
           ELSE
               MOVE    1                  TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               MOVE    ZERO                TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                      HKNCOMBI-REC
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター検索
      *****************************************************************
       910-PTNYUINRRK-SELECT-SEC        SECTION.
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター読込
      *****************************************************************
       910-PTNYUINRRK-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  PTNYUINRRK-REC
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                     PTNYUINRRK-REC
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込（主キー）
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       910-TENSU-READ-EXT.
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
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               CONTINUE
           ELSE
               DISPLAY "SELECT ERR table=" MCP-TABLE
                       " pathname="        MCP-PATHNAME
           END-IF
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
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
