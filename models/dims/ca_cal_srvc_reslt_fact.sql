{{
    config(
        materialized='incremental'
    )
}}

with data_stg as 
(
select 
    CAL_RESLT_DATA_ID,
	AS_RECVD_FIRMWARE_VER_NUM,
	AS_RECVD_RPRTD_JDGMNT,
	AS_RECVD_STD_JDGMNT,
	AS_RECVD_GURDBD_JDGMNT,
	AS_RECVD_PRCSS_JDGMNT,
	AS_RECVD_NEAR_SPCFCTN_LMT_IND,
	AS_RECVD_NEAR_GURDBD_LMT_IND,
	AS_CPMPLT_RPRTD_JDGMNT,
	AS_CPMPLT_STD_JDGMNT,
	AS_CPMPLT_GURDBD_JDGMNT,
	AS_CPMPLT_PRCSS_JDGMNT,
	AS_CPMPLT_NEAR_SPCFCTN_LMT_IND,
	AS_CPMPLT_NEAR_GURDBD_LMT_IND,
	INSERT_DT,
	UPD_DT,
	CXKEY_SRVC_ORD_NUM,
	LAST_MODIFIED_DT,
	CXKEY_CAL_PROCEDURE_ID,
	CXKEY_MFGR_ID,
	CXKEY_MFGR_MDL_NUM,
	CXKEY_SR_NUM,
	CXKEY_FRMWRK_ID,
	CXKEY_SUBMITTING_ENTITY,
	CAL_RESLT_TYP,
	CAL_DATA_INDICATOR,
	RESLT_TYP_DATA_IS_COPY
 from 
        {{ ref('ca_cal_reslt_data_stg') }}
),
reslt_stg as 
(
    select
    CAL_RESLT_ID,
	AS_CPMPLT_COND,
	AS_RECVD_COND,
	CAL_DT,
	CAL_RESLT_DATA_ID,
	CORRCTV_ACTION_VAL,
	CXKEY_CAL_PROCEDURE_ID,
	CXKEY_FRMWRK_ID,
	CXKEY_MFGR_ID,
	CXKEY_MFGR_MDL_NUM,
	CXKEY_SR_NUM,
	CXKEY_SRVC_ORD_NUM,
	CXKEY_SUBMITTING_ENTITY,
	HUMDTY_RNG_ACT,
	HUMDTY_RNG_CUST_ENV_IND,
	HUMDTY_RNG_MAX,
	HUMDTY_RNG_MIN,
	HUMDTY_RNG_NOMINAL,
	HUMDTY_RNG_TOLERANCE,
	INSERT_DT,
	UPD_DT,
	LAST_ADJ_DT,
	LAST_MODIFIED_DT,
	LINE_MAINS_FREQ_VAL,
	RESTRICT_PER_ID_STR,
	SEAL_INTACT_FLAG,
	TMP_RNG_ACT,
	TMP_RNG_CUST_ENV_IND,
	TMP_RNG_NOMINAL,
	TMP_RNG_TOLERANCE
  from
    {{ ref('ca_cal_reslt_stg') }}
),
context_stg as
(
    select
    SRVC_PRVDR_ID,
	CAL_HOURS,
	SYS_CAL_HOURS,
	CAL_RESLT_CONTXT_ID,
	ADDR_LINE_1,
	ADDR_LINE_2,
	ADDR_LINE_3,
	PRVDR_ENTY_CD,
	RESPONSIBLE_ENTY_CD,
	INSERT_DT,
	UPD_DT,
	CXKEY_SRVC_ORD_NUM,
	LAST_MODIFIED_DT,
	CXKEY_CAL_PROCEDURE_ID,
	CXKEY_MFGR_ID,
	CXKEY_MFGR_MDL_NUM,
	CXKEY_SR_NUM,
	CXKEY_FRMWRK_ID,  
	CXKEY_SUBMITTING_ENTITY
    from 
        {{ ref('ca_cal_reslt_contxt_stg') }}
 ),
    srvc_reslt_stg as 
 (
    select
    CUST_ID,
	CXKEY_SRVC_ORD_NUM,
	UNT_ID,
	REPRT_NUM,
	ENG_COMMNT,
	CALIB_SRVC_RESLT_ID,
	CAL_INTRVL_MTS,
	CAL_INTRVL_SRC_NM,
	CAL_PROCEDURE_ID,
	CAL_RESLT_CONTXT_ID,
	CAL_RESLT_ID,
	PLATFORM,
	LAST_MODIFIED_DT,
	VER_NUM,
	SUBMTTD_ENTY_NM,
	CREATED_DT,
	SRVC_TYP,
	CALIB_TYP,
	ACCRDTTN_ID,
	SRVC_DEF_ID,
    UNCRTNTY_RQRMNT_FLAG,
	SRVC_GURDBD_VAL_TYP,
	SRVC_GURDBD_VAL,
	SRVC_GURDBD_ADJ_VAL,
	SRVC_GURDBD_ADJ_VAL_TYP,
	INSERT_DT,
	UPD_DT,
	CXKEY_CAL_PROCEDURE_ID,
	CXKEY_MFGR_ID,
	CXKEY_MFGR_MDL_NUM,
	CXKEY_SR_NUM,
	CXKEY_FRMWRK_ID,
	CXKEY_SUBMITTING_ENTITY,
	CUSTOMER_NAME,
	OCN,
	OSN 
    from 
        {{ ref('ca_cal_srvc_reslt_stg') }}
),

join_121 as 
(
select 
    data_stg.CAL_RESLT_DATA_ID,
	data_stg.AS_RECVD_FIRMWARE_VER_NUM,
	data_stg.AS_RECVD_RPRTD_JDGMNT,
	data_stg.AS_RECVD_STD_JDGMNT,
	data_stg.AS_RECVD_GURDBD_JDGMNT,
	data_stg.AS_RECVD_PRCSS_JDGMNT,
	data_stg.AS_RECVD_NEAR_SPCFCTN_LMT_IND,
	data_stg.AS_RECVD_NEAR_GURDBD_LMT_IND,
	data_stg.AS_CPMPLT_RPRTD_JDGMNT,
	data_stg.AS_CPMPLT_STD_JDGMNT,
	data_stg.AS_CPMPLT_GURDBD_JDGMNT,
	data_stg.AS_CPMPLT_PRCSS_JDGMNT,
	data_stg.AS_CPMPLT_NEAR_SPCFCTN_LMT_IND,
	data_stg.AS_CPMPLT_NEAR_GURDBD_LMT_IND,
	-- data_stg.INSERT_DT,
	-- data_stg.UPD_DT,
	data_stg.CXKEY_SRVC_ORD_NUM,
	data_stg.LAST_MODIFIED_DT,
	data_stg.CXKEY_CAL_PROCEDURE_ID,
	data_stg.CXKEY_MFGR_ID,
	data_stg.CXKEY_MFGR_MDL_NUM,
	data_stg.CXKEY_SR_NUM,
	data_stg.CXKEY_FRMWRK_ID,
	data_stg.CXKEY_SUBMITTING_ENTITY,
	data_stg.CAL_RESLT_TYP,
	data_stg.CAL_DATA_INDICATOR,
	data_stg.RESLT_TYP_DATA_IS_COPY,
    
    reslt_stg.CAL_RESLT_ID,
	reslt_stg.AS_CPMPLT_COND,
	reslt_stg.AS_RECVD_COND,
	reslt_stg.CAL_DT,
	-- reslt_stg.CAL_RESLT_DATA_ID as CAL_RESLT_DATA_ID_1,
	reslt_stg.CORRCTV_ACTION_VAL,
	-- reslt_stg.CXKEY_CAL_PROCEDURE_ID,
	-- reslt_stg.CXKEY_FRMWRK_ID,
	-- reslt_stg.CXKEY_MFGR_ID,
	-- reslt_stg.CXKEY_MFGR_MDL_NUM,
	-- reslt_stg.CXKEY_SR_NUM,
	-- reslt_stg.CXKEY_SRVC_ORD_NUM,
	-- reslt_stg.CXKEY_SUBMITTING_ENTITY,
	reslt_stg.HUMDTY_RNG_ACT,
	reslt_stg.HUMDTY_RNG_CUST_ENV_IND,
	reslt_stg.HUMDTY_RNG_MAX,
	reslt_stg.HUMDTY_RNG_MIN,
	reslt_stg.HUMDTY_RNG_NOMINAL,
	reslt_stg.HUMDTY_RNG_TOLERANCE,
	-- reslt_stg.INSERT_DT,
	-- reslt_stg.UPD_DT,
	reslt_stg.LAST_ADJ_DT,
	-- reslt_stg.LAST_MODIFIED_DT,
	reslt_stg.LINE_MAINS_FREQ_VAL,
	reslt_stg.RESTRICT_PER_ID_STR,
	reslt_stg.SEAL_INTACT_FLAG,
	reslt_stg.TMP_RNG_ACT,
	reslt_stg.TMP_RNG_CUST_ENV_IND,
	reslt_stg.TMP_RNG_NOMINAL,
	reslt_stg.TMP_RNG_TOLERANCE

from data_stg, reslt_stg
where data_stg.CXKEY_SRVC_ORD_NUM = reslt_stg.CXKEY_SRVC_ORD_NUM AND
      data_stg.CXKEY_CAL_PROCEDURE_ID = reslt_stg.CXKEY_CAL_PROCEDURE_ID AND
      data_stg.CXKEY_MFGR_ID = reslt_stg.CXKEY_MFGR_ID AND
      data_stg.CXKEY_MFGR_MDL_NUM = reslt_stg.CXKEY_MFGR_MDL_NUM AND
      data_stg.CXKEY_SR_NUM = reslt_stg.CXKEY_SR_NUM AND
      data_stg.CXKEY_FRMWRK_ID = reslt_stg.CXKEY_FRMWRK_ID AND
      data_stg.CXKEY_SUBMITTING_ENTITY = reslt_stg.CXKEY_SUBMITTING_ENTITY AND
      data_stg.LAST_MODIFIED_DT = reslt_stg.LAST_MODIFIED_DT
),

join_31 as
(
select 
    context_stg.SRVC_PRVDR_ID,
	context_stg.CAL_HOURS,
	context_stg.SYS_CAL_HOURS,
	context_stg.CAL_RESLT_CONTXT_ID,
	context_stg.ADDR_LINE_1,
	context_stg.ADDR_LINE_2,
	context_stg.ADDR_LINE_3,
	context_stg.PRVDR_ENTY_CD,
	context_stg.RESPONSIBLE_ENTY_CD,
	-- context_stg.INSERT_DT,
	-- context_stg.UPD_DT,
	context_stg.CXKEY_SRVC_ORD_NUM,
	context_stg.LAST_MODIFIED_DT,
	context_stg.CXKEY_CAL_PROCEDURE_ID,
	context_stg.CXKEY_MFGR_ID,
	context_stg.CXKEY_MFGR_MDL_NUM,
	context_stg.CXKEY_SR_NUM,
	context_stg.CXKEY_FRMWRK_ID,  
	context_stg.CXKEY_SUBMITTING_ENTITY,
  
    srvc_reslt_stg.CUST_ID,
	-- srvc_reslt_stg.CXKEY_SRVC_ORD_NUM as CXKEY_SRVC_ORD_NUM1,
	srvc_reslt_stg.UNT_ID,
	srvc_reslt_stg.REPRT_NUM,
	srvc_reslt_stg.ENG_COMMNT,
	srvc_reslt_stg.CALIB_SRVC_RESLT_ID,
	srvc_reslt_stg.CAL_INTRVL_MTS,
	srvc_reslt_stg.CAL_INTRVL_SRC_NM,
	srvc_reslt_stg.CAL_PROCEDURE_ID,
	-- srvc_reslt_stg.CAL_RESLT_CONTXT_ID,
	srvc_reslt_stg.CAL_RESLT_ID,
	srvc_reslt_stg.PLATFORM,
	-- srvc_reslt_stg.LAST_MODIFIED_DT as LAST_MODIFIED_DT1,
	srvc_reslt_stg.VER_NUM,
	srvc_reslt_stg.SUBMTTD_ENTY_NM,
	srvc_reslt_stg.CREATED_DT,
	srvc_reslt_stg.SRVC_TYP,
	srvc_reslt_stg.CALIB_TYP,
	srvc_reslt_stg.ACCRDTTN_ID,
	srvc_reslt_stg.SRVC_DEF_ID,
    srvc_reslt_stg.UNCRTNTY_RQRMNT_FLAG,
	srvc_reslt_stg.SRVC_GURDBD_VAL_TYP,
	srvc_reslt_stg.SRVC_GURDBD_VAL,
	srvc_reslt_stg.SRVC_GURDBD_ADJ_VAL,
	srvc_reslt_stg.SRVC_GURDBD_ADJ_VAL_TYP,
	-- srvc_reslt_stg.INSERT_DT as INSERT_DT1,
	-- srvc_reslt_stg.UPD_DT as UPD_DT1,
	-- srvc_reslt_stg.CXKEY_CAL_PROCEDURE_ID as CXKEY_CAL_PROCEDURE_ID1,
	-- srvc_reslt_stg.CXKEY_MFGR_ID as CXKEY_MFGR_ID1,
	-- srvc_reslt_stg.CXKEY_MFGR_MDL_NUM as CXKEY_MFGR_MDL_NUM1,
	-- srvc_reslt_stg.CXKEY_SR_NUM as CXKEY_SR_NUM1,
	-- srvc_reslt_stg.CXKEY_FRMWRK_ID as CXKEY_FRMWRK_ID1,
	-- srvc_reslt_stg.CXKEY_SUBMITTING_ENTITY as CXKEY_SUBMITTING_ENTITY1,
	srvc_reslt_stg.CUSTOMER_NAME,
	srvc_reslt_stg.OCN,
	srvc_reslt_stg.OSN
  
 from context_stg, srvc_reslt_stg
  where context_stg.CXKEY_SRVC_ORD_NUM =  srvc_reslt_stg.CXKEY_SRVC_ORD_NUM AND
        context_stg.CXKEY_CAL_PROCEDURE_ID =  srvc_reslt_stg.CXKEY_CAL_PROCEDURE_ID AND
        context_stg.CXKEY_MFGR_ID =  srvc_reslt_stg.CXKEY_MFGR_ID AND
        context_stg.CXKEY_MFGR_MDL_NUM =  srvc_reslt_stg.CXKEY_MFGR_MDL_NUM AND
        context_stg.CXKEY_SR_NUM =  srvc_reslt_stg.CXKEY_SR_NUM AND
        context_stg.CXKEY_FRMWRK_ID =  srvc_reslt_stg.CXKEY_FRMWRK_ID AND
        context_stg.CXKEY_SUBMITTING_ENTITY =  srvc_reslt_stg.CXKEY_SUBMITTING_ENTITY AND
        TO_DATE(context_stg.LAST_MODIFIED_DT) =  TO_DATE(srvc_reslt_stg.LAST_MODIFIED_DT)
),
join_321 as
(
select 
    join_121.CAL_RESLT_DATA_ID,
	join_121.AS_RECVD_FIRMWARE_VER_NUM,
	join_121.AS_RECVD_RPRTD_JDGMNT,
	join_121.AS_RECVD_STD_JDGMNT,
	join_121.AS_RECVD_GURDBD_JDGMNT,
	join_121.AS_RECVD_PRCSS_JDGMNT,
	join_121.AS_RECVD_NEAR_SPCFCTN_LMT_IND,
	join_121.AS_RECVD_NEAR_GURDBD_LMT_IND,
	join_121.AS_CPMPLT_RPRTD_JDGMNT,
	join_121.AS_CPMPLT_STD_JDGMNT,
	join_121.AS_CPMPLT_GURDBD_JDGMNT,
	join_121.AS_CPMPLT_PRCSS_JDGMNT,
	join_121.AS_CPMPLT_NEAR_SPCFCTN_LMT_IND,
	join_121.AS_CPMPLT_NEAR_GURDBD_LMT_IND,
	join_121.CXKEY_SRVC_ORD_NUM,
	join_121.LAST_MODIFIED_DT,
	join_121.CXKEY_CAL_PROCEDURE_ID,
	join_121.CXKEY_MFGR_ID,
	join_121.CXKEY_MFGR_MDL_NUM,
	join_121.CXKEY_SR_NUM,
	join_121.CXKEY_FRMWRK_ID,
	join_121.CXKEY_SUBMITTING_ENTITY,
	join_121.CAL_RESLT_TYP,
	join_121.CAL_DATA_INDICATOR,
	join_121.RESLT_TYP_DATA_IS_COPY,
    join_121.CAL_RESLT_ID,
	join_121.AS_CPMPLT_COND,
	join_121.AS_RECVD_COND,
	join_121.CAL_DT,
	join_121.CORRCTV_ACTION_VAL,
	join_121.HUMDTY_RNG_ACT,
	join_121.HUMDTY_RNG_CUST_ENV_IND,
	join_121.HUMDTY_RNG_MAX,
	join_121.HUMDTY_RNG_MIN,
	join_121.HUMDTY_RNG_NOMINAL,
	join_121.HUMDTY_RNG_TOLERANCE,
	join_121.LAST_ADJ_DT,
	join_121.LINE_MAINS_FREQ_VAL,
	join_121.RESTRICT_PER_ID_STR,
	join_121.SEAL_INTACT_FLAG,
	join_121.TMP_RNG_ACT,
	join_121.TMP_RNG_CUST_ENV_IND,
	join_121.TMP_RNG_NOMINAL,
	join_121.TMP_RNG_TOLERANCE,
    join_31.SRVC_PRVDR_ID,
	join_31.CAL_HOURS,
	join_31.SYS_CAL_HOURS,
	join_31.CAL_RESLT_CONTXT_ID,
	join_31.ADDR_LINE_1,
	join_31.ADDR_LINE_2,
	join_31.ADDR_LINE_3,
	join_31.PRVDR_ENTY_CD,
	join_31.RESPONSIBLE_ENTY_CD,
    join_31.CUST_ID,
	join_31.UNT_ID,
	join_31.REPRT_NUM,
	join_31.ENG_COMMNT,
	join_31.CALIB_SRVC_RESLT_ID,
	join_31.CAL_INTRVL_MTS,
	join_31.CAL_INTRVL_SRC_NM,
	join_31.CAL_PROCEDURE_ID,
	join_31.CAL_RESLT_CONTXT_ID,
	-- join_31.CAL_RESLT_ID as CAL_RESLT_ID_1,
	join_31.PLATFORM,
	join_31.VER_NUM,
	join_31.SUBMTTD_ENTY_NM,
	join_31.CREATED_DT,
	join_31.SRVC_TYP,
	join_31.CALIB_TYP,
	join_31.ACCRDTTN_ID,
	join_31.SRVC_DEF_ID,
    join_31.UNCRTNTY_RQRMNT_FLAG,
	join_31.SRVC_GURDBD_VAL_TYP,
	join_31.SRVC_GURDBD_VAL,
	join_31.SRVC_GURDBD_ADJ_VAL,
	join_31.SRVC_GURDBD_ADJ_VAL_TYP,
    join_31.CUSTOMER_NAME,
	join_31.OCN,
	join_31.OSN
  
  
  from join_121, join_31
  where join_121.CXKEY_SRVC_ORD_NUM =  join_31.CXKEY_SRVC_ORD_NUM AND
        join_121.CXKEY_CAL_PROCEDURE_ID =  join_31.CXKEY_CAL_PROCEDURE_ID AND
        join_121.CXKEY_MFGR_ID =  join_31.CXKEY_MFGR_ID AND
        join_121.CXKEY_MFGR_MDL_NUM =  join_31.CXKEY_MFGR_MDL_NUM AND
        join_121.CXKEY_SR_NUM =  join_31.CXKEY_SR_NUM AND
        join_121.CXKEY_FRMWRK_ID =  join_31.CXKEY_FRMWRK_ID AND
        join_121.CXKEY_SUBMITTING_ENTITY =  join_31.CXKEY_SUBMITTING_ENTITY AND
        join_121.LAST_MODIFIED_DT =  join_31.LAST_MODIFIED_DT
),
expr_1 as 

(
    select
    CA_CAL_SRVC_RESLT_FACT_SEQ.nextval as CAL_CONTXT_ID,
    SRVC_PRVDR_ID,
	CAL_HOURS,
	SYS_CAL_HOURS,
	PRVDR_ENTY_CD,
	RESPONSIBLE_ENTY_CD,
	CXKEY_SRVC_ORD_NUM,
	LAST_MODIFIED_DT,
	CXKEY_CAL_PROCEDURE_ID,
	CXKEY_MFGR_ID,
    CXKEY_MFGR_ID as MFGR_ID_FOR_AGGREGATES,
	CXKEY_MFGR_MDL_NUM,
	CXKEY_SR_NUM,
	CXKEY_FRMWRK_ID,  
	CXKEY_SUBMITTING_ENTITY,
    CUST_ID,
	UNT_ID,
    REPRT_NUM,
	ENG_COMMNT,
	---- CALIB_SRVC_RESLT_ID,
	CAL_INTRVL_MTS as CAL_INTRVL,
	CAL_INTRVL_SRC_NM as CAL_INTRVL_SRC,
	CAL_PROCEDURE_ID,
	---- CAL_RESLT_ID,
	PLATFORM,
	VER_NUM,
	SUBMTTD_ENTY_NM,
	CREATED_DT,
	SRVC_TYP,
	CALIB_TYP,
	ACCRDTTN_ID,
	SRVC_DEF_ID,
    UNCRTNTY_RQRMNT_FLAG as UNCRTNTY_RQRMNT,
	SRVC_GURDBD_VAL_TYP,
	SRVC_GURDBD_VAL,
	SRVC_GURDBD_ADJ_VAL,
	SRVC_GURDBD_ADJ_VAL_TYP,
    CUSTOMER_NAME,
	OCN,
	OSN,
    AS_RECVD_FIRMWARE_VER_NUM,
	AS_RECVD_RPRTD_JDGMNT,
	AS_RECVD_STD_JDGMNT,
	AS_RECVD_GURDBD_JDGMNT,
	AS_RECVD_PRCSS_JDGMNT,
	AS_RECVD_NEAR_SPCFCTN_LMT_IND,
	AS_RECVD_NEAR_GURDBD_LMT_IND,
	AS_CPMPLT_RPRTD_JDGMNT,
	AS_CPMPLT_STD_JDGMNT,
	AS_CPMPLT_GURDBD_JDGMNT,
	AS_CPMPLT_PRCSS_JDGMNT,
	AS_CPMPLT_NEAR_SPCFCTN_LMT_IND,
	AS_CPMPLT_NEAR_GURDBD_LMT_IND,
	CAL_RESLT_TYP,
	CAL_DATA_INDICATOR,
	RESLT_TYP_DATA_IS_COPY as INST_DATA_IS_COPY,
	AS_CPMPLT_COND,
	AS_RECVD_COND,
	CAL_DT,
	CORRCTV_ACTION_VAL as CORRCTV_ACTION,
	HUMDTY_RNG_ACT,
	HUMDTY_RNG_CUST_ENV_IND,
	HUMDTY_RNG_MAX,
	HUMDTY_RNG_MIN,
	HUMDTY_RNG_NOMINAL,
	HUMDTY_RNG_TOLERANCE,
	LAST_ADJ_DT,
	LINE_MAINS_FREQ_VAL as LINE_MAINS_FREQ,
	---- RESTRICT_PER_ID_STR,
	SEAL_INTACT_FLAG,
	TMP_RNG_ACT,
	TMP_RNG_CUST_ENV_IND,
	TMP_RNG_NOMINAL,
	TMP_RNG_TOLERANCE
    from join_321
), cal_dt_update as (
    select DATE_KEY from IA_DATES join expr_1 on IA_DATES.CAL_DAY_DT = expr_1.CAL_DT

)
select distinct 
    CUST_ID,
	CXKEY_SRVC_ORD_NUM,
	UNT_ID,
	REPRT_NUM,
	ENG_COMMNT,
    CAL_CONTXT_ID,
	CAL_INTRVL,
	CAL_INTRVL_SRC,
	CAL_PROCEDURE_ID,
	SRVC_TYP,
	CALIB_TYP,
	ACCRDTTN_ID,
	SRVC_DEF_ID,
	UNCRTNTY_RQRMNT,
	SRVC_GURDBD_VAL_TYP,
	SRVC_GURDBD_VAL,
	SRVC_GURDBD_ADJ_VAL,
	CAL_HOURS,
	SYS_CAL_HOURS,
	SRVC_PRVDR_ID,
	LAST_ADJ_DT,
	AS_RECVD_COND,
	AS_CPMPLT_COND,
	CORRCTV_ACTION,
	SEAL_INTACT_FLAG,
	LINE_MAINS_FREQ,
	TMP_RNG_ACT,
	TMP_RNG_NOMINAL,
	TMP_RNG_TOLERANCE,
	TMP_RNG_CUST_ENV_IND,
	HUMDTY_RNG_ACT,
	HUMDTY_RNG_MIN,
	HUMDTY_RNG_MAX,
	HUMDTY_RNG_NOMINAL,
	HUMDTY_RNG_TOLERANCE,
	HUMDTY_RNG_CUST_ENV_IND,
	DATE_KEY as CAL_DT,
	SRVC_GURDBD_ADJ_VAL_TYP,
	PRVDR_ENTY_CD,
	RESPONSIBLE_ENTY_CD,
	AS_RECVD_RPRTD_JDGMNT,
	AS_RECVD_STD_JDGMNT,
	AS_RECVD_GURDBD_JDGMNT,
	AS_RECVD_PRCSS_JDGMNT,
	AS_RECVD_NEAR_SPCFCTN_LMT_IND,
	AS_RECVD_NEAR_GURDBD_LMT_IND,
	AS_CPMPLT_RPRTD_JDGMNT,
	AS_CPMPLT_STD_JDGMNT,
	AS_CPMPLT_GURDBD_JDGMNT,
	AS_CPMPLT_PRCSS_JDGMNT,
	AS_CPMPLT_NEAR_SPCFCTN_LMT_IND,
	AS_RECVD_FIRMWARE_VER_NUM,
	PLATFORM,
	LAST_MODIFIED_DT,
	VER_NUM,
	SUBMTTD_ENTY_NM,
	CREATED_DT,
	AS_CPMPLT_NEAR_GURDBD_LMT_IND,
	CXKEY_CAL_PROCEDURE_ID ,
	CXKEY_MFGR_ID,
	CXKEY_MFGR_MDL_NUM ,
	CXKEY_SR_NUM ,
	CXKEY_FRMWRK_ID ,
	CXKEY_SUBMITTING_ENTITY ,
	CUSTOMER_NAME,
	OCN,
	OSN,
	MFGR_ID_FOR_AGGREGATES,
	CAL_RESLT_TYP,
	CAL_DATA_INDICATOR,
	INST_DATA_IS_COPY
from expr_1 join IA_DATES on IA_DATES.CAL_DAY_DT = expr_1.CAL_DT
