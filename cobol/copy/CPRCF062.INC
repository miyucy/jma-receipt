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
      *    レセプト明細書     COPY (CPRCF062.INC)                *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    03.02.06  コメントカウントフラグの追加
      *  01.00.02    NACL-藤原    03.02.12  テスト患者番号区分の追加
      *  01.00.03    NACL-藤原    03.03.03  診療科数１０から２０へ変更
      *  01.00.04    NACL-藤原    03/03/07  レセプト記載外公費情報追加
      *  01.00.05    NACL-藤原    03.03.11  レセプト種別不明情報の追加
      *  01.00.06    NACL-門脇    03.04.16  船員保険（被保険者）＋通勤災害
      *                                     フラグの追加
      *  01.00.07    NACL-門脇    03.05.28  病棟番号・種別の追加
      *  01.00.08    NACL-門脇    03.06.19  実日数テーブルの追加
      ************************************************************
      *01  RECE62-REC.
           03  RECE62-KEY.
      *医療機関ＩＤ
               05  RECE62-HOSPID          PIC  X(24).
      *診療年月
               05  RECE62-SRYYM           PIC  9(06).
      *入外区分
               05  RECE62-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE62-PTID            PIC  9(10).
      *レセプト科
               05  RECE62-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE62-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE62-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE62-HKNJANUM-KEY    PIC  X(08).
      *補助区分
               05  RECE62-HOJOKBN-KEY     PIC  X(01).
      *適用開始年月日
               05  RECE62-TEKSTYMD        PIC  X(08). 
      *患者番号
           03  RECE62-PTNUM               PIC  X(20).
      *診療科情報
           03  RECE62-SRYKAINF            OCCURS  20.
      *診療科
               05  RECE62-SRYKA           PIC  X(02).
      *カナ氏名
           03  RECE62-KANANAME            PIC  X(50).
      *漢字氏名
           03  RECE62-NAME                PIC  X(100).
      *性別
           03  RECE62-SEX                 PIC  X(01).
      *生年月日
           03  RECE62-BIRTHDAY            PIC  9(08).
      *死亡区分
           03  RECE62-DEATHKBN            PIC  X(01).
      *年齢
           03  RECE62-AGE                 PIC  9(03).
      *主保険情報
           03  RECE62-HKN.
      *主保険−保険ＩＤ
               05  RECE62-HKNID           PIC  9(10).
      *主保険−保険番号
               05  RECE62-HKNNUM          PIC  X(03).
      *主保険−法別番号
               05  RECE62-HKNHBTNUM       PIC  X(02).
      *主保険−保険者番号
               05  RECE62-HKNJANUM        PIC  X(08).
      *主保険−本人家族区分
               05  RECE62-HONKZKKBN       PIC  X(01).
      *主保険−補助区分
               05  RECE62-HOJOKBN         PIC  X(01).
      *主保険−継続区分
               05  RECE62-CONTKBN         PIC  X(01).
      *主保険−記号
               05  RECE62-KIGO            PIC  X(80).
      *主保険−番号
               05  RECE62-NUM             PIC  X(80).
      *主保険−給付割合
               05  RECE62-KYURATE         PIC  9(03).
      *主保険−証明書番号
               05  RECE62-CERTNUM         PIC  X(03).
      *老人保健情報
           03  RECE62-RJNHKN.
      *老人保険−保険ＩＤ
               05  RECE62-RJNHKNID        PIC  9(10).
      *老人保険−保険番号
               05  RECE62-RJNHKNNUM       PIC  X(03).
      *老人保険−法別番号
               05  RECE62-RJNHBTNUM       PIC  X(02).
      *老人保険−市町村番号
               05  RECE62-RJNFTNJANUM     PIC  X(08).
      *老人保険−受給者番号
               05  RECE62-RJNJKYSNUM      PIC  X(07).
      *公費情報
           03  RECE62-KOHINF              OCCURS  4.
      *公費−保険ＩＤ
               05  RECE62-KOHID           PIC  9(10).
      *公費−保険番号
               05  RECE62-KOHNUM          PIC  X(03).
      *公費−法別番号
               05  RECE62-KOHHBTNUM       PIC  X(02).
      *公費−負担者番号
               05  RECE62-KOHFTNJANUM     PIC  X(08).
      *公費−受給者番号
               05  RECE62-KOHJKYSNUM      PIC  X(20).
      *公費−任意給付区分
               05  RECE62-KOHNINIKYUKBN   PIC  X(01).
      *公費−件数
               05  RECE62-KOHKENSU        PIC  9(03).
      *公費−レセプト請求区分
               05  RECE62-RECESKYKBN      PIC  X(01).
      *保険組合せ番号情報
           03  RECE62-HKNCOMBIINF         OCCURS  10.
      *保険組合せ番号
               05  RECE62-HKNCOMBI        PIC  9(04).
      *組合せ主保険番号
               05  RECE62-HKNNUMHC        PIC  X(03).
      *組合せ公費保険番号情報
               05  RECE62-KOHNUMHCINF     OCCURS  4.
      *組合せ公費保険番号
                   07  RECE62-KOHNUMHC    PIC  X(03).
      *診療区分別点数情報
           03  RECE62-SRYKBNINF           OCCURS  30.
      *基本点数
               05  RECE62-KHNTEN          PIC  9(08).
      *回数
               05  RECE62-KAISU           PIC  9(05).
      *明細点数情報
               05  RECE62-TENSUINF        OCCURS  5.
      *明細点数
                   07  RECE62-TENSU       PIC  9(08).
      *合計点数情報
           03  RECE62-TOTALTENINF         OCCURS  5.
      *合計点数
               05  RECE62-TOTALTEN        PIC  9(08).
      *負担金額情報
           03  RECE62-FTNMONEYINF         OCCURS  5.
      *負担金額
               05  RECE62-FTNMONEY        PIC  9(09).
      *実日数情報
           03  RECE62-JNISSUINF           OCCURS  5.
      *実日数
               05  RECE62-JNISSU          PIC  9(02).
      *
      *入院基本料種別情報
           03  RECE62-NYUSYUINF           OCCURS  20.
      *入院基本料種別
               05  RECE62-NYUSYUBETU      PIC  X(12).
      *
      *入院基本料情報
           03  RECE62-NYUKHNINF           OCCURS  10.
      *入院基本料・加算
               05  RECE62-NYUKHNRYO       PIC  9(09).
      *入院日数
               05  RECE62-NYUKHNNISSU     PIC  9(02).
      *合計金額情報
               05  RECE62-NYUKHNKEIINF    OCCURS  5.
      *合計金額
                   07  RECE62-NYUKHNKEI   PIC  9(09).
      *入院基本料情報２
           03  RECE62-NYUKHNINF2.
      *合計金額情報２
               05  RECE62-NYUKHNKEIINF2   OCCURS  5.
      *合計金額２
                   07  RECE62-NYUKHNKEI2  PIC S9(09).
      *
      *特定入院基本料情報
           03  RECE62-NYUTOKINF           OCCURS  10.
      *特定入院料・その他（点）
               05  RECE62-NYUTOKRYO       PIC  9(09).
      *特定入院料・その他（略称）
               05  RECE62-NYUTOKRYO-RYAKU PIC  X(14).
      *入院日数
               05  RECE62-NYUTOKNISSU     PIC  9(02).
      *合計金額情報
               05  RECE62-NYUTOKKEIINF    OCCURS  5.
      *合計金額
                   07  RECE62-NYUTOKKEI   PIC  9(09).
      *
      *特定入院基本料情報２
           03  RECE62-NYUTOKINF2.
      *合計金額情報２
               05  RECE62-NYUTOKKEIINF2   OCCURS  5.
      *合計金額２
                   07  RECE62-NYUTOKKEI2  PIC S9(09).
      *
      *食事療養費情報
           03  RECE62-SHOKUJIINF          OCCURS  5.
      *食事日数
               05  RECE62-SHOKUJINISSU    PIC  9(02).
      *食事療養費
               05  RECE62-SHOKUJIRYOYOHI  PIC  9(09).
      *標準負担額
               05  RECE62-SHOKUJIFTN      PIC  9(09).
      *標準負担区分
           03  RECE62-SHOKUJIFTNKBN       PIC  X(01).
      *
      *食事種別情報
           03  RECE62-SHOKUJISYUINF       OCCURS   3.
      *食事種別
               05  RECE62-SHOKUJISYUBETU  PIC  X(04).
      *
      *食事基本料情報
           03  RECE62-SHOKUJIKHNINF       OCCURS   4.
      *食事基本料
               05  RECE62-SHOKUJIKHNRYO   PIC  9(09).
      *食事日数
               05  RECE62-SHOKUJIKHNNISSU PIC  9(02).
      *
      *最終診療科
           03  RECE62-LASTSRYKA           PIC  X(02).
      *
      *入院年月日
           03  RECE62-NYUINYMD            PIC  X(08).
      *
      *医療機関種別
           03  RECE62-HOSPSBT             PIC  X(01).
      *特記事項情報
           03  RECE62-TOKKIINF            OCCURS  5.
      *特記事項
               05  RECE62-TOKKI           PIC  X(02).
      *病棟区分情報
           03  RECE62-BYOTOKBNINF         OCCURS  4.
      *病棟区分
               05  RECE62-BYOTOKBN        PIC  X(02).
      *病棟種別情報
           03  RECE62-BYOTOSYUBETUINF     OCCURS 31.
      *病棟番号
               05  RECE62-BYOTONUM        PIC  X(02).
      *病棟種別
               05  RECE62-BYOTOSYUBETU    PIC  X(02).
      *レセプト記載外公費情報（保険番号以外は現在未設定）
           03  RECE62-ETC-KOH-G.
               05  RECE62-ETC-KOHINF      OCCURS  4.
      *記載外公費−保険番号
                   07  RECE62-ETC-KOHNUM  PIC  X(03).
      *記載外公費−実日数
                   07  RECE62-ETC-JNISSU   PIC  9(02).
      *記載外公費−合計点数
                   07  RECE62-ETC-TOTALTEN PIC  9(08).
      *記載外公費−負担金額
                   07  RECE62-ETC-FTNMONEY PIC  9(09).
      *記載外公費−薬剤一部負担金情報
                   07  RECE62-ETC-YKZFTN   PIC  9(05).
      *低所得フラグ
           03  RECE62-TEISYOTOKU          PIC  X(01).
      *高齢者フラグ
           03  RECE62-KOUREI              PIC  X(01).
      *高齢者一部負担金再掲
           03  RECE62-KOUREI-SAIKEI       PIC  9(09).
      *船員保険（被保険者）＋通勤災害フラグ
           03  RECE62-SENIN-TUUSAI        PIC  X(01).
      *補足区分
           03  RECE62-HOSOKUKBN           PIC  X(01).
      *初診時間区分
           03  RECE62-SHOSHINTIME         PIC  X(01).
      *老人減免区分
           03  RECE62-RJNGENMENKBN        PIC  X(01).
      *老人外来金額
           03  RECE62-RJNGAIFTN           PIC  9(09).
      *老人入院金額
           03  RECE62-RJNNYUFTN           PIC  9(09).
      *国保減免区分
           03  RECE62-KKHGENMENKBN        PIC  X(01).
      *国保減額割合
           03  RECE62-KKHGENGAKURATE      PIC  X(03).
      *国保減額金額
           03  RECE62-KKHGENGAKU          PIC  X(03).
      *割引点数単価
           03  RECE62-DISCOUNTTENTNK      PIC  X(02).
      *老人公費負担金額情報
           03  RECE62-RJNKOHFTNINF        OCCURS  3.
      *老人外来公費負担額
               05  RECE62-RJNGAIKOHFTN    PIC  9(09).
      *老人入院公費負担額
               05  RECE62-RJNNYUKOHFTN    PIC  9(09).
      *コメントカウントフラグ
           03  RECE62-COMCNTFLG           PIC  X(01).
      *テスト患者番号区分
           03  RECE62-TSTPTNUMKBN         PIC  X(01).
      *レセプト種別不明エラー情報
           03  RECE62-ERR-AREA.
               05  RECE62-ERR-ERRKBN      PIC 9(01).
               05  RECE62-ERR-DAY         PIC 9(02).
               05  RECE62-ERR-HKNCOMBINUM PIC 9(04).
               05  RECE62-ERR-TEKSTYMD    PIC 9(08).
               05  RECE62-ERR-TEKEDYMD    PIC 9(08).
      *予備
           03  RECE62-FILLER              PIC  X(32).
      *
