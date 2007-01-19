\set ON_ERROR_STOP
--
-- ¼ýÇ¼ÍúÎò¥Æ¡¼¥Ö¥ë
-- 
-- Create Date : 2006/01/19         --
--
CREATE TABLE "tbl_syurrk" (
	"hospid"		character(24) NOT NULL,
	"ptid"			numeric(10,0) DEFAULT 0 NOT NULL,
	"nyugaikbn"		character(1) NOT NULL,
	"denpnum"		integer  NOT NULL,
	"syurrknum"		integer  NOT NULL,
	"syuedanum"		integer  NOT NULL,
	"sryka"			character(2),
	"hkncombinum"		character(4),
	"total_hknten" 		integer  DEFAULT 0,
	"hkntekmoney" 		integer  DEFAULT 0,
	"rjn_ftn" 		integer  DEFAULT 0,
	"koh_ftn" 		integer  DEFAULT 0,
	"rsi_total" 		integer  DEFAULT 0,
	"jihi_total" 		integer  DEFAULT 0,
	"jihi_total_tax" 	integer  DEFAULT 0,
	"jihi_tax"		integer  DEFAULT 0,
	"total_tgmoney" 	integer  DEFAULT 0,
	"total_tgmoney_tax" 	integer  DEFAULT 0,
	"skymoney_skj_jihi_kei" integer  DEFAULT 0,
	"skymoney_life_jihi_kei" integer  DEFAULT 0,
	"rmsagaku" 		integer  DEFAULT 0,
	"skymoney_skj_kei" 	integer  DEFAULT 0,
	"skymoney_life_kei" 	integer  DEFAULT 0,
	"skymoney" 		integer  DEFAULT 0,
	"chosei" 		integer  DEFAULT 0,
	"discount_money" 	integer  DEFAULT 0,
	"jihi_1" 		integer  DEFAULT 0,
	"jihi_1_tax" 		integer  DEFAULT 0,
	"jihi_2" 		integer  DEFAULT 0,
	"jihi_2_tax" 		integer  DEFAULT 0,
	"jihi_3" 		integer  DEFAULT 0,
	"jihi_3_tax" 		integer  DEFAULT 0,
	"jihi_4" 		integer  DEFAULT 0,
	"jihi_4_tax" 		integer  DEFAULT 0,
	"jihi_5" 		integer  DEFAULT 0,
	"jihi_5_tax" 		integer  DEFAULT 0,
	"jihi_6" 		integer  DEFAULT 0,
	"jihi_6_tax" 		integer  DEFAULT 0,
	"jihi_7" 		integer  DEFAULT 0,
	"jihi_7_tax" 		integer  DEFAULT 0,
	"jihi_8" 		integer  DEFAULT 0,
	"jihi_8_tax" 		integer  DEFAULT 0,
	"jihi_9" 		integer  DEFAULT 0,
	"jihi_9_tax" 		integer  DEFAULT 0,
	"jihi_10" 		integer  DEFAULT 0,
	"jihi_10_tax" 		integer  DEFAULT 0,
	"termid" character varying(16),
	"opid" character varying(16),
	"creymd" character(8),
	"upymd" character(8),
	"uphms" character(6),
	Constraint "tbl_syurrk_primary_key" Primary Key ("hospid", "ptid", "nyugaikbn", "denpnum","syurrknum","syuedanum")
);

COMMENT ON TABLE "tbl_syurrk" IS '¼ýÇ¼ÍúÎò';

