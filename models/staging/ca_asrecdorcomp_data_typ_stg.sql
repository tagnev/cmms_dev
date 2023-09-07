{{
    config(
        materialized='table',
    )
}}

with ca_asrecdorcomp_data_typ_raw_stg 
as
(
select * from ca_asrecdorcomp_data_typ_raw
),
exp_calserviceresults 
as
(
  select 
  "ServiceOrderNumber",
"LastModified",
"SubmittingEntity",
"ManufID",
"ManufModel",
"SerialNumber",
"ProcedureID",
"AppFramework_FrameworkID",
  "ResultsType",
  "AS_CMP_ResultsType",
  IFF("ResultsType"='AS_COMPLETED','E',
IFF("AS_CMP_ResultsType"='AS_RECEIVED','E',
IFF("ResultsType"='BOTH','B',
IFF("ResultsType"='AS_RECEIVED' AND "AS_CMP_ResultsType" is null,'R',
IFF("AS_CMP_ResultsType"='AS_COMPLETED' AND "ResultsType" is null,'C',
IFF("ResultsType"='AS_RECEIVED' AND "AS_CMP_ResultsType"='AS_COMPLETED','A','X')))))) as RT,
  RT as RESULTS_TYPE,
  IFF("ResultsType"='AS_COMPLETED','E',
IFF("AS_CMP_ResultsType"='AS_RECEIVED','E',
IFF("ResultsType"='BOTH','B',
IFF("ResultsType"='AS_RECEIVED' AND "AS_CMP_ResultsType" is null,'R',
IFF("AS_CMP_ResultsType"='AS_COMPLETED' AND "ResultsType" is null,'C',
IFF("ResultsType"='AS_RECEIVED' AND "AS_CMP_ResultsType"='AS_COMPLETED','A','X')))))) as v_FLAG,
  IFF(RT = 'C',"AS_CMP_TestName","TestName") as Out_AS_RECEIVED_TestName,
IFF(RT = 'C',"AS_CMP_TestStartTime","TestStartTime") as Out_AS_RECEIVED_TestStartTime,
IFF(RT = 'C',"AS_CMP_Station","Station") as Out_AS_RECEIVED_Station,
IFF(RT = 'C',"AS_CMP_TestEndTime","TestEndTime") as Out_AS_RECEIVED_TestEndTime,
IFF(RT = 'C',"AS_CMP_ReportName","ReportName") as Out_AS_RECEIVED_ReportName,
IFF(RT = 'C',"AS_CMP_ResultsType","ResultsType") as Out_AS_RECEIVED_ResultsType,
IFF(RT = 'C',"AS_CMP_UncertaintyStatus","UncertaintyStatus") as Out_AS_RECEIVED_UncertaintyStatus,
IFF(RT = 'C',"AS_CMP_ReportedJudgement","ReportedJudgement") as Out_AS_RECEIVED_ReportedJudgement,
IFF(RT = 'C',"AS_CMP_StandardJudgement","StandardJudgement") as Out_AS_RECEIVED_StandardJudgement,
IFF(RT = 'C',"AS_CMP_GuardbandJudgement","GuardbandJudgement") as Out_AS_RECEIVED_GuardbandJudgement,
IFF(RT = 'C',"AS_CMP_ProcessJudgement","ProcessJudgement") as Out_AS_RECEIVED_ProcessJudgement,
IFF(RT = 'C',"AS_CMP_NearSpecificationLimit","NearSpecificationLimit") as Out_AS_RECEIVED_NearSpecificationLimit,
IFF(RT = 'C',"AS_CMP_NearGuardbandLimit","NearGuardbandLimit") as Out_AS_RECEIVED_NearGuardbandLimit,
IFF(RT = 'C',"AS_CMP_FirmwareVersion","FirmwareVersion") as Out_AS_RECEIVED_FirmwareVersion,
IFF(RT = 'C',"AS_CMP_WorkCenterID","WorkCenterID") as Out_AS_RECEIVED_WorkCenterID,
IFF(RT = 'C',"AS_CMP_AdjustedCoverageFactor","AdjustedCoverageFactor") as Out_AS_RECEIVED_AdjustedCoverageFactor,
IFF(RT = 'C',"AS_CMP_AppPlatform","AppPlatform") as Out_AS_RECEIVED_AppPlatform,
IFF(RT = 'C',"AS_CMP_AppVersion","AppVersion") as Out_AS_RECEIVED_AppVersion,
IFF(RT = 'C',"AS_CMP_AppID","AppID") as Out_AS_RECEIVED_AppID,
IFF(RT = 'C',"AS_CMP_LimitedTUR","LimitedTUR") as Out_AS_RECEIVED_LimitedTUR,
IFF(RT = 'C',"AS_CMP_AsCompletedReportedJudgement","AsReceivedReportedJudgement") as CAL_TST_AsReceivedReportedJudgement,
IFF(RT = 'C',"AS_CMP_AsCompletedStandardJudgement","AsReceivedStandardJudgement") as CAL_TST_AsReceivedStandardJudgement,
IFF(RT = 'C',"AS_CMP_AsCompletedGuardbandJudgement","AsReceivedGuardbandJudgement") as CAL_TST_AsReceivedGuardbandJudgement,
IFF(RT = 'C',"AS_CMP_AsCompletedProcessJudgement","AsReceivedProcessJudgement") as CAL_TST_AsReceivedProcessJudgement,
IFF(RT = 'C',"AS_CMP_AsCompletedNearSpecificationLimit","AsReceivedNearSpecificationLimit") as CAL_TST_AsReceivedNearSpecificationLimit,
IFF(RT = 'C',"AS_CMP_AsCompletedNearGuardbandLimit","AsReceivedNearGuardbandLimit") as CAL_TST_AsReceivedNearGuardbandLimit,
IFF(RT = 'R' or RT = 'B',"AS_CMP_TestName","TestName") as Out_AS_COMPLETED_TestName,
IFF(RT = 'R' or RT = 'B',"AS_CMP_TestStartTime","TestStartTime") as Out_AS_COMPLETED_TestStartTime,
IFF(RT = 'R' or RT = 'B',"AS_CMP_Station","Station") as Out_AS_COMPLETED_Station,
IFF(RT = 'R' or RT = 'B',"AS_CMP_TestEndTime","TestEndTime") as Out_AS_COMPLETED_TestEndTime,
IFF(RT = 'R' or RT = 'B',"AS_CMP_ReportName","ReportName") as Out_AS_COMPLETED_ReportName,
IFF(RT = 'R' or RT = 'B',"AS_CMP_ResultsType","ResultsType") as Out_AS_COMPLETED_ResultsType,
IFF(RT = 'R' or RT = 'B',"AS_CMP_UncertaintyStatus","UncertaintyStatus") as Out_AS_COMPLETED_UncertaintyStatus,
IFF(RT = 'R' or RT = 'B',"AS_CMP_ReportedJudgement","ReportedJudgement") as Out_AS_COMPLETED_ReportedJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_StandardJudgement","StandardJudgement") as Out_AS_COMPLETED_StandardJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_GuardbandJudgement","GuardbandJudgement") as Out_AS_COMPLETED_GuardbandJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_ProcessJudgement","ProcessJudgement") as Out_AS_COMPLETED_ProcessJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_NearSpecificationLimit","NearSpecificationLimit") as Out_AS_COMPLETED_NearSpecificationLimit,
IFF(RT = 'R' or RT = 'B',"AS_CMP_NearGuardbandLimit","NearGuardbandLimit") as Out_AS_COMPLETED_NearGuardbandLimit,
IFF(RT = 'R' or RT = 'B',"AS_CMP_FirmwareVersion","FirmwareVersion") as Out_AS_COMPLETED_FirmwareVersion,
IFF(RT = 'R' or RT = 'B',"AS_CMP_WorkCenterID","WorkCenterID") as Out_AS_COMPLETED_WorkCenterID,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AdjustedCoverageFactor","AdjustedCoverageFactor") as Out_AS_COMPLETED_AdjustedCoverageFactor,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AppPlatform","AppPlatform") as Out_AS_COMPLETED_AppPlatform,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AppVersion","AppVersion") as Out_AS_COMPLETED_AppVersion,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AppID","AppID") as Out_AS_COMPLETED_AppID,
IFF(RT = 'R' or RT = 'B',"AS_CMP_LimitedTUR","LimitedTUR") as Out_AS_COMPLETED_LimitedTUR,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedReportedJudgement","AsReceivedReportedJudgement") as CAL_TST_AsCompletedReportedJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedStandardJudgement","AsReceivedStandardJudgement") as CAL_TST_AsCompletedStandardJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedGuardbandJudgement","AsReceivedGuardbandJudgement") as CAL_TST_AsCompletedGuardbandJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedProcessJudgement","AsReceivedProcessJudgement") as CAL_TST_AsCompletedProcessJudgement,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedNearSpecificationLimit","AsReceivedNearSpecificationLimit") as CAL_TST_AsCompletedNearSpecificationLimit,
IFF(RT = 'R' or RT = 'B',"AS_CMP_AsCompletedNearGuardbandLimit","AsReceivedNearGuardbandLimit") as CAL_TST_AsCompletedNearGuardbandLimit,
  IFF(RT = 'R',IFF(CAL_TST_AsCompletedReportedJudgement='NOT_DONE' OR CAL_TST_AsCompletedReportedJudgement='UNKNOWN' OR CAL_TST_AsCompletedReportedJudgement is null,'TRUE','FALSE'),IFF(RT='C',IFF(CAL_TST_AsReceivedReportedJudgement='NOT_DONE' OR CAL_TST_AsReceivedReportedJudgement='UNKNOWN' OR CAL_TST_AsReceivedReportedJudgement is null,'TRUE','FALSE'),IFF(RT='B','TRUE','FALSE'))) as ResultsTypeDataIsCopy
  from
  ca_asrecdorcomp_data_typ_raw_stg
),
exp_asreceivedata
as
(
  select *,
      IFF(RT= 'C' AND "ResultsType" is null,'AS_RECEIVED',
IFF(RT= 'B' AND NOT "ResultsType" is null,'AS_RECEIVED',
IFF(RT= 'X' AND "ResultsType" is null,'AS_RECEIVED',
"ResultsType"))) as Flag
  from exp_calserviceresults
),
exp_ascompletedata
as
(
  select *,
  IFF(RT= 'R' AND "AS_CMP_ResultsType" is null,'AS_RECEIVED',
IFF(RT= 'B' AND NOT "AS_CMP_ResultsType" is null,'AS_RECEIVED',
IFF(RT= 'X' AND "AS_CMP_ResultsType" is null,'AS_RECEIVED',
"AS_CMP_ResultsType"))) as Flag
  from exp_calserviceresults
),
union_trans as 
(
  select * from exp_asreceivedata
  union all
  select * from exp_ascompletedata
),
after_union_trans
as 
(
select 
"ServiceOrderNumber" as CXKEY_SRVC_ORD_NUM,
"LastModified" as LAST_MODIFIED_DT,
"SubmittingEntity" as CXKEY_SUBMITTING_ENTITY,
"ManufID" as CXKEY_MFGR_ID,
"ManufModel" as CXKEY_MFGR_MDL_NUM,
"SerialNumber" as CXKEY_SR_NUM,
"ProcedureID" as CXKEY_CAL_PROCEDURE_ID,
"AppFramework_FrameworkID" as CXKEY_FRMWRK_ID,
OUT_AS_RECEIVED_TESTNAME as CXKEY_TEST_NM,
OUT_AS_RECEIVED_TESTSTARTTIME as TEST_ST_TIME,
OUT_AS_RECEIVED_STATION as STTN_NM,
OUT_AS_RECEIVED_TESTENDTIME as TEST_END_TIME,
OUT_AS_RECEIVED_REPORTNAME as REPRT_NM,
OUT_AS_RECEIVED_RESULTSTYPE as CXKEY_RESLT_TYP,
OUT_AS_RECEIVED_UNCERTAINTYSTATUS as UNCRTNTY_STAT_VAL,
OUT_AS_RECEIVED_REPORTEDJUDGEMENT as RPRTD_JDGMNT,
OUT_AS_RECEIVED_STANDARDJUDGEMENT as STD_JDGMNT,
OUT_AS_RECEIVED_GUARDBANDJUDGEMENT as GURDBD_JDGMNT,
OUT_AS_RECEIVED_PROCESSJUDGEMENT as PRCSS_JDGMNT,
OUT_AS_RECEIVED_NEARSPECIFICATIONLIMIT as NEAR_SPCFCTN_LMT_IND,
OUT_AS_RECEIVED_NEARGUARDBANDLIMIT as NEAR_GURDBD_LMT_IND,
OUT_AS_RECEIVED_FIRMWAREVERSION as FIRMWARE_VER,
OUT_AS_RECEIVED_WORKCENTERID as WRK_CENTER_ID,
OUT_AS_RECEIVED_ADJUSTEDCOVERAGEFACTOR as COVERAGE_FACTOR,
OUT_AS_RECEIVED_APPPLATFORM as CXKEY_APP_PLATFORM,
OUT_AS_RECEIVED_APPVERSION as APP_VER_NUM,
OUT_AS_RECEIVED_APPID as CXKEY_APP_ID,
OUT_AS_RECEIVED_LIMITEDTUR as LMTED_TUR,
CAL_TST_ASRECEIVEDREPORTEDJUDGEMENT as CAL_TEST_RESLT_RPRTD_JDGMNT,
CAL_TST_ASRECEIVEDSTANDARDJUDGEMENT as CAL_TEST_RESLT_STD_JDGMNT,
CAL_TST_ASRECEIVEDGUARDBANDJUDGEMENT as CAL_TEST_RESLT_GURDBD_JDGMNT,
CAL_TST_ASRECEIVEDPROCESSJUDGEMENT as CAL_TEST_RESLT_PRCSS_JDGMNT,
CAL_TST_ASRECEIVEDNEARSPECIFICATIONLIMIT as CAL_TST_RSLT_NR_SPFTN_LMT_IND,
CAL_TST_ASRECEIVEDNEARGUARDBANDLIMIT as CAL_TST_RSLT_NR_GRDBD_LMT_IND,
OUT_AS_COMPLETED_TESTNAME as AS_CMP_TEST_NM,
OUT_AS_COMPLETED_TESTSTARTTIME as AS_CMP_TEST_ST_TIME,
OUT_AS_COMPLETED_STATION as AS_CMP_STTN_NM,
OUT_AS_COMPLETED_TESTENDTIME as AS_CMP_TEST_END_TIME,
OUT_AS_COMPLETED_REPORTNAME as AS_CMP_REPRT_NM,
OUT_AS_COMPLETED_UNCERTAINTYSTATUS as AS_CMP_UNCNTRTY_STAT_VAL,
OUT_AS_COMPLETED_REPORTEDJUDGEMENT as AS_CMP_RPRTD_JDGMNT,
OUT_AS_COMPLETED_STANDARDJUDGEMENT as AS_CMP_STD_JDGMNT,
OUT_AS_COMPLETED_GUARDBANDJUDGEMENT as AS_CMP_GURDBD_JDGMNT,
OUT_AS_COMPLETED_PROCESSJUDGEMENT as AS_CMP_PRCSS_JDGMNT,
OUT_AS_COMPLETED_NEARSPECIFICATIONLIMIT as AS_CMP_NEAR_SPCFCTN_LMT_IND,
OUT_AS_COMPLETED_NEARGUARDBANDLIMIT as AS_CMP_NEAR_GURDBD_LMT_IND,
OUT_AS_COMPLETED_FIRMWAREVERSION as AS_CMP_FIRMWARE_VER,
OUT_AS_COMPLETED_WORKCENTERID as AS_CMP_WRK_CENTER_ID,
OUT_AS_COMPLETED_ADJUSTEDCOVERAGEFACTOR as AS_CMP_ADJ_COVERAGE_FACTOR,
OUT_AS_COMPLETED_APPPLATFORM as AS_CMP_APP_PLATFORM,
OUT_AS_COMPLETED_APPVERSION as AS_CMP_APP_VER_NUM,
OUT_AS_COMPLETED_APPID as AS_CMP_APP_ID,
OUT_AS_COMPLETED_LIMITEDTUR as AS_CMP_LMTED_TUR,
CAL_TST_ASCOMPLETEDREPORTEDJUDGEMENT as AS_CMP_CAL_TST_RPRTD_JDGMNT,
CAL_TST_ASCOMPLETEDSTANDARDJUDGEMENT as AS_CMP_CAL_TST_STD_JDGMNT,
CAL_TST_ASCOMPLETEDGUARDBANDJUDGEMENT as AS_CMP_CAL_TST_GURDBD_JDGMNT,
CAL_TST_ASCOMPLETEDPROCESSJUDGEMENT as AS_CMP_CAL_TST_PRCSS_JDGMNT,
CAL_TST_ASCOMPLETEDNEARSPECIFICATIONLIMIT as AS_CMP_CAL_TST_NR_SPTN_LT_IND,
CAL_TST_ASCOMPLETEDNEARGUARDBANDLIMIT as AS_CMP_CAL_TST_NR_GDBD_LMT_IND,
RESULTSTYPEDATAISCOPY as RESLT_TYP_DATAIS_COPY,
FLAG
from union_trans
  ),
  exp_asrecdorcomp
  as
  (
    select 
    CXKEY_SRVC_ORD_NUM,
LAST_MODIFIED_DT,
lower(CXKEY_SUBMITTING_ENTITY) as CXKEY_SUBMITTING_ENTITY,
CXKEY_MFGR_ID,
CXKEY_MFGR_MDL_NUM,
CXKEY_SR_NUM,
CXKEY_CAL_PROCEDURE_ID,
CXKEY_FRMWRK_ID,
CXKEY_TEST_NM,
TEST_ST_TIME,
STTN_NM,
TEST_END_TIME,
REPRT_NM,
CXKEY_RESLT_TYP,
UNCRTNTY_STAT_VAL,
RPRTD_JDGMNT,
STD_JDGMNT,
GURDBD_JDGMNT,
PRCSS_JDGMNT,
NEAR_SPCFCTN_LMT_IND,
NEAR_GURDBD_LMT_IND,
FIRMWARE_VER,
WRK_CENTER_ID,
COVERAGE_FACTOR,
IFF (CXKEY_APP_PLATFORM is null,CXKEY_CAL_PROCEDURE_ID,CXKEY_APP_PLATFORM) as CXKEY_APP_PLATFORM,
APP_VER_NUM,
IFF (CXKEY_APP_ID is null,CXKEY_FRMWRK_ID,CXKEY_APP_ID) as CXKEY_APP_ID,
LMTED_TUR,
CAL_TEST_RESLT_RPRTD_JDGMNT,
CAL_TEST_RESLT_STD_JDGMNT,
CAL_TEST_RESLT_GURDBD_JDGMNT,
CAL_TEST_RESLT_PRCSS_JDGMNT,
CAL_TST_RSLT_NR_SPFTN_LMT_IND,
CAL_TST_RSLT_NR_GRDBD_LMT_IND,
AS_CMP_TEST_NM,
AS_CMP_TEST_ST_TIME,
AS_CMP_STTN_NM,
AS_CMP_TEST_END_TIME,
AS_CMP_REPRT_NM,
AS_CMP_UNCNTRTY_STAT_VAL,
AS_CMP_RPRTD_JDGMNT,
AS_CMP_STD_JDGMNT,
AS_CMP_GURDBD_JDGMNT,
AS_CMP_PRCSS_JDGMNT,
AS_CMP_NEAR_SPCFCTN_LMT_IND,
AS_CMP_NEAR_GURDBD_LMT_IND,
AS_CMP_FIRMWARE_VER,
AS_CMP_WRK_CENTER_ID,
AS_CMP_ADJ_COVERAGE_FACTOR,
IFF (AS_CMP_APP_PLATFORM is null,CXKEY_CAL_PROCEDURE_ID,AS_CMP_APP_PLATFORM) as AS_CMP_APP_PLATFORM,
AS_CMP_APP_VER_NUM,
IFF (AS_CMP_APP_ID is null,CXKEY_FRMWRK_ID,AS_CMP_APP_ID) as AS_CMP_APP_ID,
AS_CMP_LMTED_TUR,
AS_CMP_CAL_TST_RPRTD_JDGMNT,
AS_CMP_CAL_TST_STD_JDGMNT,
AS_CMP_CAL_TST_GURDBD_JDGMNT,
AS_CMP_CAL_TST_PRCSS_JDGMNT,
AS_CMP_CAL_TST_NR_SPTN_LT_IND,
AS_CMP_CAL_TST_NR_GDBD_LMT_IND,
RESLT_TYP_DATAIS_COPY,
FLAG,
NULL as INSERT_DT,
NULL as UPD_DT
from after_union_trans
  ),
  fil_trans
  as
  (
  select * from exp_asrecdorcomp
  where FLAG!='E'  
  ),
  final 
  as
  (
  select distinct
    CXKEY_TEST_NM,
TEST_ST_TIME,
TEST_END_TIME,
STTN_NM,
REPRT_NM,
CXKEY_RESLT_TYP,
COVERAGE_FACTOR,
LMTED_TUR,
FIRMWARE_VER,
WRK_CENTER_ID,
APP_VER_NUM,
CXKEY_APP_ID,
CXKEY_APP_PLATFORM,
NEAR_SPCFCTN_LMT_IND,
NEAR_GURDBD_LMT_IND,
(CA_ASRECDORCOMP_DATA_TYP_STG_SEQ.nextval) as CAL_TEST_DATA_TYP_ID,
FLAG as ASRECDORCOMP_DATA_IND,
UNCRTNTY_STAT_VAL,
RPRTD_JDGMNT,
STD_JDGMNT,
GURDBD_JDGMNT,
PRCSS_JDGMNT,
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
RESLT_TYP_DATAIS_COPY,
CAL_TEST_RESLT_RPRTD_JDGMNT,
CAL_TEST_RESLT_STD_JDGMNT,
CAL_TEST_RESLT_GURDBD_JDGMNT,
CAL_TEST_RESLT_PRCSS_JDGMNT,
CAL_TST_RSLT_NR_SPFTN_LMT_IND,
CAL_TST_RSLT_NR_GRDBD_LMT_IND,
AS_CMP_TEST_NM,
AS_CMP_TEST_ST_TIME,
AS_CMP_TEST_END_TIME,
AS_CMP_STTN_NM,
AS_CMP_REPRT_NM,
AS_CMP_WRK_CENTER_ID,
AS_CMP_LMTED_TUR,
AS_CMP_FIRMWARE_VER,
AS_CMP_APP_VER_NUM,
AS_CMP_APP_ID,
AS_CMP_APP_PLATFORM,
AS_CMP_UNCNTRTY_STAT_VAL,
AS_CMP_RPRTD_JDGMNT,
AS_CMP_STD_JDGMNT,
AS_CMP_GURDBD_JDGMNT,
AS_CMP_PRCSS_JDGMNT,
AS_CMP_NEAR_SPCFCTN_LMT_IND,
AS_CMP_NEAR_GURDBD_LMT_IND,
AS_CMP_ADJ_COVERAGE_FACTOR,
AS_CMP_CAL_TST_RPRTD_JDGMNT,
AS_CMP_CAL_TST_STD_JDGMNT,
AS_CMP_CAL_TST_GURDBD_JDGMNT,
AS_CMP_CAL_TST_PRCSS_JDGMNT,
AS_CMP_CAL_TST_NR_SPTN_LT_IND,
AS_CMP_CAL_TST_NR_GDBD_LMT_IND
  from fil_trans
    )
    select * from final