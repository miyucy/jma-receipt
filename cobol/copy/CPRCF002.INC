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
      ************************************************************
      *    レセプト明細書     COPY (CPRCF02.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.01.01    MCC-藤原     02.02.01  補足区分の追加
      *  01.01.04    MCC-藤原     02.02.13  保険組合せを３から１０に変更
      *
      *  ２００２年４月改正対応
      *  01.02.01    MCC-小豆沢   02.04.22  レセプト摘要欄の印刷区分を追加
      *                                     再診料、外来管理加算について
      *  ２００２年１０月改正対応
      *  01.02.02    NACL-小豆沢  02.09.24  年齢項目の追加
      *  01.02.03    NACL-門脇    02.10.07  在宅総合・末期フラグの追加
      *                                     低所得フラグの追加
      *                                     一部負担金再掲の追加
      *
      *  01.02.04    NACL-門脇    03.02.06  コメントカウントフラグの追加
      *  01.02.05    NACL-藤原    03/02/12  テスト患者番号区分・補助区分の追加
      *  01.02.06    NACL-藤原    03/03/07  レセプト記載外公費情報追加
      *                                     診療科数１０から２０へ変更
      *  01.02.07    NACL-藤原    03.03.11  レセプト種別不明情報の追加
      *  01.02.08    NACL-門脇    03.04.16  船員保険（被保険者）＋通勤災害
      *                                     フラグの追加
      *  01.02.09    NACL-門脇    03.06.19  実日数テーブルの追加
      *  01.02.10    NACL-藤原    03.10.27  県番号の追加
      *  01.02.11    NACL-門脇    04.01.16  公費分離区分最小値の追加
      *  01.02.12    NACL-門脇    04.01.19  病床数編集フラグの追加
      ************************************************************
      *01  RECE02-REC.
           03  RECE02-KEY.
      *医療機関ＩＤ
               05  RECE02-HOSPID          PIC  X(24).
      *診療年月
               05  RECE02-SRYYM           PIC  9(06).
      *入外区分
               05  RECE02-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE02-PTID            PIC  9(10).
      *レセプト科
               05  RECE02-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE02-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE02-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE02-HKNJANUM-KEY    PIC  X(08).
      *補助区分
               05  RECE02-HOJOKBN-KEY     PIC  X(01).
      *適用開始年月日
               05  RECE02-TEKSTYMD        PIC  X(08). 
      *患者番号
           03  RECE02-PTNUM               PIC  X(20).
      *診療科情報
           03  RECE02-SRYKAINF            OCCURS  20.
      *診療科
               05  RECE02-SRYKA           PIC  X(02).
      *カナ氏名
           03  RECE02-KANANAME            PIC  X(50).
      *漢字氏名
           03  RECE02-NAME                PIC  X(100).
      *性別
           03  RECE02-SEX                 PIC  X(01).
      *生年月日
           03  RECE02-BIRTHDAY            PIC  9(08).
      *死亡区分
           03  RECE02-DEATHKBN            PIC  X(01).
      *主保険情報
           03  RECE02-HKN.
      *主保険−保険ＩＤ
               05  RECE02-HKNID           PIC  9(10).
      *主保険−保険番号
               05  RECE02-HKNNUM          PIC  X(03).
      *主保険−法別番号
               05  RECE02-HKNHBTNUM       PIC  X(02).
      *主保険−保険者番号
               05  RECE02-HKNJANUM        PIC  X(08).
      *主保険−本人家族区分
               05  RECE02-HONKZKKBN       PIC  X(01).
      *主保険−補助区分
               05  RECE02-HOJOKBN         PIC  X(01).
      *主保険−継続区分
               05  RECE02-CONTKBN         PIC  X(01).
      *主保険−記号
               05  RECE02-KIGO            PIC  X(80).
      *主保険−番号
               05  RECE02-NUM             PIC  X(80).
      *主保険−給付割合
               05  RECE02-KYURATE         PIC  9(03).
      *主保険−証明書番号
               05  RECE02-CERTNUM         PIC  X(03).
      *老人保健情報
           03  RECE02-RJNHKN.
      *老人保険−保険ＩＤ
               05  RECE02-RJNHKNID        PIC  9(10).
      *老人保険−保険番号
               05  RECE02-RJNHKNNUM       PIC  X(03).
      *老人保険−法別番号
               05  RECE02-RJNHBTNUM       PIC  X(02).
      *老人保険−市町村番号
               05  RECE02-RJNFTNJANUM     PIC  X(08).
      *老人保険−受給者番号
               05  RECE02-RJNJKYSNUM      PIC  X(07).
      *公費情報
           03  RECE02-KOHINF              OCCURS  4.
      *公費−保険ＩＤ
               05  RECE02-KOHID           PIC  9(10).
      *公費−保険番号
               05  RECE02-KOHNUM          PIC  X(03).
      *公費−法別番号
               05  RECE02-KOHHBTNUM       PIC  X(02).
      *公費−負担者番号
               05  RECE02-KOHFTNJANUM     PIC  X(08).
      *公費−受給者番号
               05  RECE02-KOHJKYSNUM      PIC  X(20).
      *公費−任意給付区分
               05  RECE02-KOHNINIKYUKBN   PIC  X(01).
      *公費−件数
               05  RECE02-KOHKENSU        PIC  9(03).
      *公費−レセプト請求区分
               05  RECE02-RECESKYKBN      PIC  X(01).
      *保険組合せ番号情報
           03  RECE02-HKNCOMBIINF         OCCURS  10.
      *保険組合せ番号
               05  RECE02-HKNCOMBI        PIC  9(04).
      *主保険番号
               05  RECE02-HKNNUMHC        PIC  X(03).
      *組合せ公費保険番号情報
               05  RECE02-KOHNUMHCINF     OCCURS  4.
      *組合せ公費保険番号
                   07  RECE02-KOHNUMHC    PIC  X(03).
      *特記事項情報
           03  RECE02-TOKKIINF            OCCURS  5.
      *特記事項
               05  RECE02-TOKKI           PIC  X(02).
      *病棟区分情報
           03  RECE02-BYOTOKBNINF         OCCURS  4.
      *病棟区分
               05  RECE02-BYOTOKBN        PIC  X(02).
      *実日数情報
           03  RECE02-JNISSUINF           OCCURS  5.
      *実日数
               05  RECE02-JNISSU          PIC  9(02).
      *診療区分別点数情報
           03  RECE02-SRYKBNINF           OCCURS  50.
      *基本点数
               05  RECE02-KHNTEN          PIC  9(08).
      *回数
               05  RECE02-KAISU           PIC  9(05).
      *明細点数情報
               05  RECE02-TENSUINF        OCCURS  5.
      *明細点数
                   07  RECE02-TENSU       PIC  9(08).
      *合計点数情報
           03  RECE02-TOTALTENINF         OCCURS  5.
      *合計点数
               05  RECE02-TOTALTEN        PIC  9(08).
      *負担金額情報
           03  RECE02-FTNMONEYINF         OCCURS  5.
      *負担金額
               05  RECE02-FTNMONEY        PIC  9(09).
      *老人減免区分
           03  RECE02-RJNGENMENKBN        PIC  X(01).
      *老人外来金額
           03  RECE02-RJNGAIFTN           PIC  9(09).
      *老人入院金額
           03  RECE02-RJNNYUFTN           PIC  9(09).
      *国保減免区分
           03  RECE02-KKHGENMENKBN        PIC  X(01).
      *国保減額割合
           03  RECE02-KKHGENGAKURATE      PIC  X(03).
      *国保減額金額
           03  RECE02-KKHGENGAKU          PIC  X(03).
      *割引点数単価
           03  RECE02-DISCOUNTTENTNK      PIC  X(02).
      *食事療養費情報
           03  RECE02-SHOKUJIINF          OCCURS  5.
      *食事日数
               05  RECE02-SHOKUJINISSU    PIC  9(02).
      *食事療養費
               05  RECE02-SHOKUJIRYOYOHI  PIC  9(09).
      *標準負担額
               05  RECE02-SHOKUJIFTN      PIC  9(09).
      *標準負担区分
           03  RECE02-SHOKUJIFTNKBN       PIC  X(01).
      *老人公費負担金額情報
           03  RECE02-RJNKOHFTNINF        OCCURS  3.
      *老人外来公費負担額
               05  RECE02-RJNGAIKOHFTN    PIC  9(09).
      *老人入院公費負担額
               05  RECE02-RJNNYUKOHFTN    PIC  9(09).
      *薬剤一部負担金情報
           03  RECE02-YKZFTNINF           OCCURS  5.
      *薬剤一部負担金
               05  RECE02-YKZFTN          PIC  9(05).
      *レセプトＯＣＲ１
           03  RECE02-OCR1                PIC  X(67).
      *レセプトＯＣＲ２
           03  RECE02-OCR2                PIC  X(67).
      *レセプトＯＣＲ３
           03  RECE02-OCR3                PIC  X(67).
      *レセプト記載外公費情報（保険番号以外は現在未設定）
           03  RECE02-ETC-KOH-G.
               05  RECE02-ETC-KOHINF      OCCURS  4.
      *記載外公費−保険番号
                   07  RECE02-ETC-KOHNUM  PIC  X(03).
      *記載外公費−実日数
                   07  RECE02-ETC-JNISSU   PIC  9(02).
      *記載外公費−合計点数
                   07  RECE02-ETC-TOTALTEN PIC  9(08).
      *記載外公費−負担金額
                   07  RECE02-ETC-FTNMONEY PIC  9(09).
      *記載外公費−薬剤一部負担金情報
                   07  RECE02-ETC-YKZFTN   PIC  9(05).
      *補足区分
           03  RECE02-HOSOKUKBN           PIC  X(01).
      *初診時間区分
           03  RECE02-SHOSHINTIME         PIC  X(01).
      *再診摘要印刷区分
           03  RECE02-SAISHIN-PRTKBN      PIC  X(01).
      *外来管理加算摘要印刷区分
           03  RECE02-GAIRAIKSN-PRTKBN    PIC  X(01).
      *年齢
           03  RECE02-AGE                 PIC  9(03).
      *低所得フラグ
           03  RECE02-TEISYOTOKU          PIC  X(01).
      *在宅総合・在宅末期フラグ
           03  RECE02-ZAITAKU             PIC  X(01).
      *在宅総合・在宅末期一部負担金再掲
           03  RECE02-ZAITAKU-SAIKEI      PIC  9(09).
      *船員保険（被保険者）＋通勤災害フラグ
           03  RECE02-SENIN-TUUSAI        PIC  X(01).
      *コメントカウントフラグ
           03  RECE02-COMCNTFLG           PIC  X(01).
      *テスト患者番号区分
           03  RECE02-TSTPTNUMKBN         PIC  X(01).
      *レセプト種別不明エラー情報
           03  RECE02-ERR-AREA.
               05  RECE02-ERR-ERRKBN      PIC 9(01).
               05  RECE02-ERR-DAY         PIC 9(02).
               05  RECE02-ERR-HKNCOMBINUM PIC 9(04).
               05  RECE02-ERR-TEKSTYMD    PIC 9(08).
               05  RECE02-ERR-TEKEDYMD    PIC 9(08).
      *
      *実日数テーブル情報
           03  RECE02-JNISSUTBLINF        OCCURS 31.
      *実日数テーブル
               05  RECE02-JNISSUTBL       PIC  X(01).
      *乳幼児・幼児のコメントフラグ
           03  RECE02-NYUYOJIFLG          PIC  X(01).
      *
      *公費実日数テーブル情報
           03  RECE02-KOHJNISSUTBLINF.
      *公費実日数テーブル
               05  RECE02-KOHJNISSUTBL    PIC  X(01)
                                          OCCURS 31.
      *県番号
           03  RECE02-PREFNUM             PIC  9(02).
      *公費分離区分最小値
           03  RECE02-KOHBUNRI-MIN        PIC  9(01).
      *病床数編集フラグ（特定疾患療養指導料等）
           03  RECE02-BEDSUFLG            PIC  X(01).
      *
