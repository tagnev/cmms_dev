 {{
    config(
        materialized='incremental',
        unique_key=['SRVC_PRVDR_ID', 'UNT_ID', 'CAL_PROCEDURE_ID', 'CAL_TEST_RESLT_ID', 'TEST_DATA_UNIQUE_ID']
    )
}}

with SQ_Z_LKP_2 as (

SELECT
               CA_TEST_DATA_SCTN.APPLD_UNCRTNTY_TYP as LKP_APPLD_UNCRTNTY_TYP,
               CA_TEST_DATA_SCTN.REPRT_MSRD_AS_DIFFERENCE_IND as LKP_REPRT_MSRD_AS_DIFFERENCE_IND,
               CA_TEST_DATA_SCTN.REPRT_MSRD_AS_TOLERANCE_IND as LKP_REPRT_MSRD_AS_TOLERANCE_IND,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_NEAR_SPCFCTN_LM as LKP_TEST_DATA_SCTN_NEAR_SPCFCTN_LM,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_NEAR_GURDBD_LMT as LKP_TEST_DATA_SCTN_NEAR_GURDBD_LMT,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_ID as LKP_TEST_DATA_SCTN_ID,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_TITLE as LKP_TEST_DATA_SCTN_TITLE,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_RPRTD_JDGMNT as LKP_TEST_DATA_SCTN_RPRTD_JDGMNT,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_STD_JDGMNT as LKP_TEST_DATA_SCTN_STD_JDGMNT,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_GURDBD_JDGMNT as LKP_TEST_DATA_SCTN_GURDBD_JDGMNT,
               CA_TEST_DATA_SCTN.TEST_DATA_SCTN_PRCSS_JDGMNT as LKP_TEST_DATA_SCTN_PRCSS_JDGMNT,
               CA_TEST_DATA_SCTN.CAL_TEST_RESLT_ID as LKP_CAL_TEST_RESLT_ID,
               CA_TEST_DATA_SCTN.SRVC_PRVDR_ID as LKP_SRVC_PRVDR_ID,
               CA_TEST_DATA_SCTN.UNT_ID as LKP_UNT_ID,
               CA_TEST_DATA_SCTN.CUST_ID as LKP_CUST_ID,
               CA_TEST_DATA_SCTN.CAL_PROCEDURE_ID as LKP_CAL_PROCEDURE_ID,
               CA_TEST_DATA_SCTN.TEST_DATA_UNIQUE_ID as LKP_TEST_DATA_UNIQUE_ID,
               CA_TEST_DATA_SCTN.LAST_MODIFIED_DT as LKP_LAST_MODIFIED_DT,
               CA_TEST_DATA_SCTN.IS_CHARACTERIZATION_DATA as LKP_IS_CHARACTERIZATION_DATA,
               CA_TEST_DATA_SCTN.RESLT_TYP_DATAIS_COPY as LKP_RESLT_TYP_DATAIS_COPY,
               CA_TEST_DATA_SCTN.ASRECDORCOMP_DATA_IND as LKP_ASRECDORCOMP_DATA_IND,
               CA_TEST_DATA_SCTN.CAL_DT as LKP_CAL_DT,
               CA_TEST_DATA_SCTN.CXKEY_TEST_DATA_SCTN_NM as LKP_CXKEY_TEST_DATA_SCTN_NM,
               CA_TEST_DATA_SCTN.CXKEY_SRVC_ORD_NUM as LKP_CXKEY_SRVC_ORD_NUM,
               CA_TEST_DATA_SCTN.CXKEY_CAL_PROCEDURE_ID as LKP_CXKEY_CAL_PROCEDURE_ID,
               CA_TEST_DATA_SCTN.CXKEY_MFGR_ID as LKP_CXKEY_MFGR_ID,
               CA_TEST_DATA_SCTN.CXKEY_MFGR_MDL_NUM as LKP_CXKEY_MFGR_MDL_NUM,
               CA_TEST_DATA_SCTN.CXKEY_SR_NUM as LKP_CXKEY_SR_NUM,
               CA_TEST_DATA_SCTN.CXKEY_FRMWRK_ID as LKP_CXKEY_FRMWRK_ID,
               CA_TEST_DATA_SCTN.CXKEY_SUBMITTING_ENTITY as LKP_CXKEY_SUBMITTING_ENTITY,
               CA_TEST_DATA_SCTN.CXKEY_CAL_TEST_RESLT_NM as LKP_CXKEY_CAL_TEST_RESLT_NM,
               CA_TEST_DATA_SCTN.CXKEY_CAL_TEST_RESLT_TYP as LKP_CXKEY_CAL_TEST_RESLT_TYP,
               CA_TEST_DATA_SCTN.CXKEY_APP_PLATFORM as LKP_CXKEY_APP_PLATFORM,
               CA_TEST_DATA_SCTN.CXKEY_APP_ID as LKP_CXKEY_APP_ID
FROM
               CA_TEST_DATA_SCTN
WHERE
               CXKEY_SRVC_ORD_NUM IN (
                              SELECT
                                             DISTINCT CXKEY_SRVC_ORD_NUM
                              FROM
                                             "SANDBOX"."CMMS_POC"."CA_TEST_DATA_SCTN_STG" STG
               )
)

,
SQ_Z_LKP_3 as (
  SELECT
               CA_CAL_TEST_RESLT_FACT.CAL_TEST_RESLT_ID as LKP2_CAL_TEST_RESLT_ID,
               CA_CAL_TEST_RESLT_FACT.CUST_ID as LKP2_CUST_ID,
               CA_CAL_TEST_RESLT_FACT.UNT_ID as LKP2_UNT_ID,
               CA_CAL_TEST_RESLT_FACT.SRVC_PRVDR_ID as LKP2_SRVC_PRVDR_ID,
               CA_CAL_TEST_RESLT_FACT.CAL_PROCEDURE_ID as LKP2_CAL_PROCEDURE_ID,
               CA_CAL_TEST_RESLT_FACT.CAL_DT as LKP2_CAL_DT,
               CA_CAL_TEST_RESLT_FACT.CXKEY_SRVC_ORD_NUM as LKP2_CXKEY_SRVC_ORD_NUM,
               CA_CAL_TEST_RESLT_FACT.LAST_MODIFIED_DT as LKP2_LAST_MODIFIED_DT,
               CA_CAL_TEST_RESLT_FACT.CXKEY_CAL_PROCEDURE_ID as LKP2_CXKEY_CAL_PROCEDURE_ID,
               CA_CAL_TEST_RESLT_FACT.CXKEY_MFGR_ID as LKP2_CXKEY_MFGR_ID,
               CA_CAL_TEST_RESLT_FACT.CXKEY_MFGR_MDL_NUM as LKP2_CXKEY_MFGR_MDL_NUM,
               CA_CAL_TEST_RESLT_FACT.CXKEY_SR_NUM as LKP2_CXKEY_SR_NUM,
               CA_CAL_TEST_RESLT_FACT.CXKEY_FRMWRK_ID as LKP2_CXKEY_FRMWRK_ID,
               CA_CAL_TEST_RESLT_FACT.CXKEY_SUBMITTING_ENTITY as LKP2_CXKEY_SUBMITTING_ENTITY,
               CA_CAL_TEST_RESLT_FACT.CXKEY_CAL_TEST_RESLT_NM as LKP2_CXKEY_CAL_TEST_RESLT_NM,
               CA_CAL_TEST_RESLT_FACT.CXKEY_RESLT_TYP as LKP2_CXKEY_RESLT_TYP,
               CA_CAL_TEST_RESLT_FACT.CXKEY_APP_PLATFORM as LKP2_CXKEY_APP_PLATFORM,
               CA_CAL_TEST_RESLT_FACT.CXKEY_APP_ID as LKP2_CXKEY_APP_ID
FROM
               "SANDBOX"."CMMS_POC"."CA_CAL_TEST_RESLT_FACT" CA_CAL_TEST_RESLT_FACT
WHERE
               LAST_MODIFIED_DT IN (
                              SELECT
                                             DISTINCT LAST_MODIFIED_DT
                              FROM
                                             "SANDBOX"."CMMS_POC"."CA_TEST_DATA_SCTN_STG" STG
               )
),

 --select LKP2_SRVC_PRVDR_ID,count(*) from SQ_Z_LKP_3 group by LKP2_SRVC_PRVDR_ID having count(*) > 1;
EXP_1 as (
select
    ASRECDORCOMP_DATA_IND,
    ASRECDORCOMP_DATA_IND as DI,
    CXKEY_CAL_TEST_RESLT_TYP,
    case
        when
            (
                CXKEY_CAL_TEST_RESLT_TYP = 'AS_RECEIVED'
            )
        then 'R'
        else 'C'
    end as RT,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN APPLD_UNCRTNTY_TYP
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN APPLD_UNCRTNTY_TYP
         ELSE AS_CMP_APPLD_UNCRTNTY_TYP
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_APPLD_UNCRTNTY_TYP
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_APPLD_UNCRTNTY_TYP
         ELSE APPLD_UNCRTNTY_TYP
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN APPLD_UNCRTNTY_TYP
         ELSE AS_CMP_APPLD_UNCRTNTY_TYP
      END
   ELSE
      APPLD_UNCRTNTY_TYP
   END AS APPLD_UNCRTNTY_TYP,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN REPRT_MSRD_AS_DIFFERENCE_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN REPRT_MSRD_AS_DIFFERENCE_IND
         ELSE AS_CMP_RPRTD_MSRD_AS_DFF_IND
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_RPRTD_MSRD_AS_DFF_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_RPRTD_MSRD_AS_DFF_IND
         ELSE REPRT_MSRD_AS_DIFFERENCE_IND
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN REPRT_MSRD_AS_DIFFERENCE_IND
         ELSE AS_CMP_RPRTD_MSRD_AS_DFF_IND
      END
   ELSE
      REPRT_MSRD_AS_DIFFERENCE_IND
   END AS REPRT_MSRD_AS_DIFFERENCE_IND,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN REPRT_MSRD_AS_TOLERANCE_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN REPRT_MSRD_AS_TOLERANCE_IND
         ELSE AS_CMP_RPRTD_MSRD_AS_DFF_IND
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_RPRTD_MSRD_AS_DFF_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_RPRTD_MSRD_AS_DFF_IND
         ELSE REPRT_MSRD_AS_TOLERANCE_IND
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN REPRT_MSRD_AS_TOLERANCE_IND
         ELSE AS_CMP_RPRTD_MSRD_AS_DFF_IND
      END
   ELSE
      REPRT_MSRD_AS_TOLERANCE_IND
   END AS REPRT_MSRD_AS_TOLERANCE_IND,
   
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN NEAR_SPCFCTN_LMT_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN NEAR_SPCFCTN_LMT_IND
         ELSE AS_CMP_NR_SPCFCTN_LMT_IND
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_NR_SPCFCTN_LMT_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_NR_SPCFCTN_LMT_IND
         ELSE NEAR_SPCFCTN_LMT_IND
     END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN NEAR_SPCFCTN_LMT_IND
         ELSE AS_CMP_NR_SPCFCTN_LMT_IND
      END
   ELSE
      NEAR_SPCFCTN_LMT_IND
   END AS NEAR_SPCFCTN_LMT_IND,
  
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN NEAR_GURDBD_LMT_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN NEAR_GURDBD_LMT_IND
         ELSE AS_CMP_NR_GURDBD_LMT_IND
      END
   WHEN DI='C' THEN
     CASE 
         WHEN RT='C' THEN AS_CMP_NR_GURDBD_LMT_IND
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_NR_GURDBD_LMT_IND
         ELSE NEAR_GURDBD_LMT_IND
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN NEAR_GURDBD_LMT_IND
         ELSE AS_CMP_NR_GURDBD_LMT_IND
      END
   ELSE
      NEAR_GURDBD_LMT_IND
   END AS NEAR_GURDBD_LMT_IND,
  
   TEST_DATA_SCTN_ID,
   
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_TEST_DATA_SCTN_NM
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN CXKEY_TEST_DATA_SCTN_NM
         ELSE AS_CMP_TST_DATA_SCTN_NM
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_TST_DATA_SCTN_NM
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_TST_DATA_SCTN_NM
         ELSE CXKEY_TEST_DATA_SCTN_NM
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_TEST_DATA_SCTN_NM
         ELSE AS_CMP_TST_DATA_SCTN_NM
      END
   ELSE
      CXKEY_TEST_DATA_SCTN_NM
   END AS CXKEY_TEST_DATA_SCTN_NM,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN TITLE
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN TITLE
         ELSE AS_CMP_SCTN_TITLE
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_SCTN_TITLE
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_SCTN_TITLE
         ELSE TITLE
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN TITLE
         ELSE AS_CMP_SCTN_TITLE
      END
   ELSE
      TITLE
   END AS TITLE,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN RPRTD_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN RPRTD_JDGMNT
         ELSE AS_CMP_RPRTD_JDGMNT
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_RPRTD_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_RPRTD_JDGMNT
         ELSE RPRTD_JDGMNT
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN RPRTD_JDGMNT
         ELSE AS_CMP_RPRTD_JDGMNT
      END
   ELSE
      RPRTD_JDGMNT
   END AS RPRTD_JDGMNT,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN STD_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN STD_JDGMNT
         ELSE AS_CMP_STND_JDGMNT
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_STND_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_STND_JDGMNT
         ELSE STD_JDGMNT
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN STD_JDGMNT
         ELSE AS_CMP_STND_JDGMNT
      END
   ELSE
      STD_JDGMNT
   END AS STD_JDGMNT,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN GURDBD_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN GURDBD_JDGMNT
         ELSE AS_CMP_GURDBD_JDG
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_GURDBD_JDG
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_GURDBD_JDG
         ELSE GURDBD_JDGMNT
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN GURDBD_JDGMNT
         ELSE AS_CMP_GURDBD_JDG
      END
   ELSE
      GURDBD_JDGMNT
   END AS GURDBD_JDGMNT,
   
   
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN PRCSS_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN PRCSS_JDGMNT
         ELSE AS_CMP_PRCSS_JDGMNT
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_PRCSS_JDGMNT
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_PRCSS_JDGMNT
         ELSE PRCSS_JDGMNT
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN PRCSS_JDGMNT
         ELSE AS_CMP_PRCSS_JDGMNT
      END
   ELSE
      PRCSS_JDGMNT
   END AS PRCSS_JDGMNT,
  
  INSERT_DT,
  UPD_DT,
  CXKEY_SRVC_ORD_NUM,
  TEST_DATA_ID,
  LAST_MODIFIED_DT,
  CXKEY_CAL_PROCEDURE_ID,
  CXKEY_MFGR_ID,
  CXKEY_MFGR_MDL_NUM,
  CXKEY_SR_NUM,
  CXKEY_FRMWRK_ID,
  CXKEY_SUBMITTING_ENTITY,
  CXKEY_APP_PLATFORM,

  CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_APP_PLATFORM
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN CXKEY_APP_PLATFORM
         ELSE AS_CMP_APP_PLTFRM
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_APP_PLTFRM
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_APP_PLTFRM
         ELSE CXKEY_APP_PLATFORM
      END
  WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_APP_PLATFORM
         ELSE AS_CMP_APP_PLTFRM
      END
   ELSE
      CXKEY_APP_PLATFORM
   END AS VAR_CXKEY_APP_PLATFORM,
  
   CASE WHEN VAR_CXKEY_APP_PLATFORM IS NOT NULL THEN VAR_CXKEY_APP_PLATFORM ELSE CXKEY_FRMWRK_ID END AS APP_PLATFORM,
  
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_APP_ID
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN CXKEY_APP_ID
         ELSE AS_CMP_APP_ID
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_APP_ID
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_APP_ID
         ELSE CXKEY_APP_ID
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN CXKEY_APP_ID
         ELSE AS_CMP_APP_ID
      END
   ELSE
      CXKEY_APP_ID
   END AS VAR_CXKEY_APP_ID,
  
   CASE WHEN VAR_CXKEY_APP_ID IS NULL THEN CXKEY_CAL_PROCEDURE_ID ELSE VAR_CXKEY_APP_ID END AS APP_ID,
  
   CXKEY_CAL_TEST_RESLT_NM,
   
   CASE 
   WHEN DI='R' THEN
      CASE 
         WHEN RT='R' THEN IS_CHARACTERIZATION_DATA
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN IS_CHARACTERIZATION_DATA
         ELSE AS_CMP_IS_CHRTN_DATA
      END
   WHEN DI='C' THEN
      CASE 
         WHEN RT='C' THEN AS_CMP_IS_CHRTN_DATA
         WHEN CAL_TST_RPRTD_JDG='NOT_DONE' OR CAL_TST_RPRTD_JDG='UNKNOWN' OR CAL_TST_RPRTD_JDG IS NULL THEN AS_CMP_IS_CHRTN_DATA
         ELSE IS_CHARACTERIZATION_DATA
      END
   WHEN DI='A' OR DI='X' THEN
      CASE 
         WHEN RT='R' THEN IS_CHARACTERIZATION_DATA
         ELSE AS_CMP_IS_CHRTN_DATA
      END
   ELSE
      IS_CHARACTERIZATION_DATA
   END AS IS_CHARACTERIZATION_DATA,
  
   RESLT_TYP_DATAIS_COPY

  
   FROM "SANDBOX"."CMMS_POC"."CA_TEST_DATA_SCTN_STG" STG
   
),
LKPTRANS3 as (

select
  
STG.*, TGT.*

  FROM EXP_1 STG
  LEFT OUTER JOIN SQ_Z_LKP_2 TGT
  ON
    STG.CXKEY_TEST_DATA_SCTN_NM = TGT.LKP_CXKEY_TEST_DATA_SCTN_NM
  AND
STG.CXKEY_SRVC_ORD_NUM = TGT.LKP_CXKEY_SRVC_ORD_NUM 
   
AND STG.LAST_MODIFIED_DT = TGT.LKP_LAST_MODIFIED_DT 
AND  STG.CXKEY_CAL_PROCEDURE_ID = TGT.LKP_CXKEY_CAL_PROCEDURE_ID 
AND    STG.CXKEY_MFGR_ID = TGT.LKP_CXKEY_MFGR_ID 
AND  STG.CXKEY_MFGR_MDL_NUM =  TGT.LKP_CXKEY_MFGR_MDL_NUM
  AND
    STG.CXKEY_SR_NUM = TGT.LKP_CXKEY_SR_NUM 
AND STG.CXKEY_FRMWRK_ID = TGT.LKP_CXKEY_FRMWRK_ID 
AND  STG.CXKEY_SUBMITTING_ENTITY = TGT.LKP_CXKEY_SUBMITTING_ENTITY 
AND   STG.CXKEY_CAL_TEST_RESLT_NM  = TGT.LKP_CXKEY_CAL_TEST_RESLT_NM 
AND   STG.CXKEY_CAL_TEST_RESLT_TYP  = TGT.LKP_CXKEY_CAL_TEST_RESLT_TYP 
-- AND   STG.CXKEY_APP_PLATFORM  = TGT.LKP_CXKEY_APP_PLATFORM 
  AND
    STG.APP_ID  = TGT.LKP_CXKEY_APP_ID
)
,



LKPTRANS4 as (

select
STG.*, TGT.*

  FROM LKPTRANS3 STG
  LEFT OUTER JOIN SQ_Z_LKP_3 TGT
  ON
    STG.CXKEY_SRVC_ORD_NUM = TGT.LKP2_CXKEY_SRVC_ORD_NUM AND
    STG.LAST_MODIFIED_DT = TGT.LKP2_LAST_MODIFIED_DT AND
    STG.CXKEY_CAL_PROCEDURE_ID = TGT.LKP2_CXKEY_CAL_PROCEDURE_ID AND
STG.CXKEY_MFGR_ID = TGT.LKP2_CXKEY_MFGR_ID AND
   STG.CXKEY_MFGR_MDL_NUM =  TGT.LKP2_CXKEY_MFGR_MDL_NUM AND
    STG.CXKEY_SR_NUM = TGT.LKP2_CXKEY_SR_NUM AND
    STG.CXKEY_FRMWRK_ID = TGT.LKP2_CXKEY_FRMWRK_ID AND
    STG.CXKEY_SUBMITTING_ENTITY = TGT.LKP2_CXKEY_SUBMITTING_ENTITY AND
    STG.CXKEY_CAL_TEST_RESLT_NM  = TGT.LKP2_CXKEY_CAL_TEST_RESLT_NM AND
    STG.CXKEY_CAL_TEST_RESLT_TYP  = TGT.LKP2_CXKEY_RESLT_TYP 
  --  STG.CXKEY_APP_PLATFORM  = TGT.LKP2_CXKEY_APP_PLATFORM AND
   -- STG.APP_ID  = TGT.LKP2_CXKEY_APP_ID
)
,

final as (
select
distinct
    APPLD_UNCRTNTY_TYP,
               REPRT_MSRD_AS_DIFFERENCE_IND,
               REPRT_MSRD_AS_TOLERANCE_IND,
               NEAR_SPCFCTN_LMT_IND AS TEST_DATA_SCTN_NEAR_SPCFCTN_LM,
               NEAR_GURDBD_LMT_IND AS TEST_DATA_SCTN_NEAR_GURDBD_LMT,
               --TEST_DATA_SCTN_ID,
               CXKEY_TEST_DATA_SCTN_NM,
               TITLE AS TEST_DATA_SCTN_TITLE,
               RPRTD_JDGMNT AS TEST_DATA_SCTN_RPRTD_JDGMNT,
               STD_JDGMNT AS TEST_DATA_SCTN_STD_JDGMNT,
               GURDBD_JDGMNT AS TEST_DATA_SCTN_GURDBD_JDGMNT,
               PRCSS_JDGMNT AS TEST_DATA_SCTN_PRCSS_JDGMNT,
               LKP2_CAL_TEST_RESLT_ID as CAL_TEST_RESLT_ID,
               LKP2_SRVC_PRVDR_ID as SRVC_PRVDR_ID,
               LKP2_UNT_ID as UNT_ID,
               LKP2_CUST_ID as CUST_ID,
               LKP2_CAL_PROCEDURE_ID as CAL_PROCEDURE_ID,
               TEST_DATA_ID as TEST_DATA_UNIQUE_ID,
               CXKEY_SRVC_ORD_NUM,
               LAST_MODIFIED_DT,
               CXKEY_CAL_PROCEDURE_ID,
               CXKEY_MFGR_ID,
               CXKEY_MFGR_MDL_NUM,
               CXKEY_SR_NUM,
               CXKEY_FRMWRK_ID,
               CXKEY_SUBMITTING_ENTITY,
               CXKEY_CAL_TEST_RESLT_NM,1
               CXKEY_CAL_TEST_RESLT_TYP,
               CXKEY_APP_PLATFORM,
               APP_ID as CXKEY_APP_ID,
               IS_CHARACTERIZATION_DATA,
               RESLT_TYP_DATAIS_COPY,
               ASRECDORCOMP_DATA_IND,
               LKP2_CAL_DT as CAL_DT

    FROM LKPTRANS4 

)

select *,ca_test_data_sctn_stg_seq.nextval as test_data_sctn_id  from final 